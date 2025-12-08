import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:finful_app/core/core.dart';
import 'package:finful_app/core/exception/api_exception.dart';
import 'package:finful_app/core/extension/string_extension.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as file_util;
import 'package:retry/retry.dart';

import 'config.dart';

const defaultErrorJson = '{"data": {"message": "Error occurred while '
    'Communication with Server with StatusCode"}}';

const payloadTooLargeErrorJson = '{"data": {"message": "Payload too large"}}';

const currentAuthorizationKey = 'key_current_authorization';

class FileData {
  final File file;
  final String type;
  FileData({
    required this.file,
    required this.type,
  });
}

typedef AuthorizationCallback = Authorization? Function();

abstract class BaseRemote {
  late Client _client;
  late HeaderConfig _config;
  AuthorizationCallback? _getAuthorization;

  BaseRemote({
    Client? client,
    required HeaderConfig config,
    AuthorizationCallback? getAuthorization,
  }) {
    _client = client ?? Client();
    _config = config;
    _getAuthorization = getAuthorization;
  }

  Uri _getParsedUrl({
    required String method,
    required String path,
    Map<String, dynamic>? params,
  }) {
    if (method == 'GET') {
      return Uri.parse(path).replace(queryParameters: params);
    }

    return Uri.parse(path);
  }

  String getAuthorizationHeader(ApiHeaderType type, Request request) {
    final authorization = _getAuthorization?.call();
    switch (type) {
      case ApiHeaderType.normal:
        return 'Bearer ${_config.encodedCredentials}';
      case ApiHeaderType.withToken:
        return 'Bearer ${authorization?.accessToken}';
      case ApiHeaderType.withoutToken:
        return request.headers[HttpHeaders.authorizationHeader] ?? '';
    }
  }

  Future<bool> _refreshToken() async {
    final authorization = _getAuthorization?.call();
    if (authorization == null || authorization.refreshToken.isNullOrEmpty) {
      return false;
    }

    try {
      final requestBody = {
        'refreshToken': authorization.refreshToken,
      };
      final url = _getParsedUrl(
        method: 'POST',
        path: _config.refreshTokenPath,
      );

      final headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.accessControlAllowOriginHeader: '*',
        HttpHeaders.accessControlAllowMethodsHeader:
        'POST, GET, OPTIONS, PUT, DELETE, HEAD',
      };
      final response = await _client.post(url,
          headers: headers, body: jsonEncode(requestBody));

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        final jsonData = responseJson['data'];
        final newAuth = Authorization(
          accessToken: jsonData['accessToken'],
          refreshToken: jsonData['refreshToken'],
          userId: jsonData['userId']
        );
        _getAuthorization = () => newAuth;
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove(currentAuthorizationKey);
        await prefs.setString(
            currentAuthorizationKey, json.encode(newAuth.toJson()));
        return true;
      }

      return false;
    } catch (e) {
      logger().debug('Refresh Token Error: $e');
      return false;
    }
  }

  Future<dynamic> _call(
      String method,
      String path,
      ApiHeaderType type, {
        Map<String, String>? customHeader,
        dynamic data,
      }) async {
    final url = _getParsedUrl(
      method: method,
      path: path,
      params: method == 'GET' ? data : null,
    );
    logger().debug('Call API >> $method >> url: $url >> body: $data');
    dynamic responseJson;
    var numberAttempts = 0;
    try {
      final request = Request(
          method,
          _getParsedUrl(
              method: method,
              path: path,
              params: method == 'GET' ? data : null));
      request.headers[HttpHeaders.contentTypeHeader] = 'application/json';
      request.headers[HttpHeaders.authorizationHeader] =
          getAuthorizationHeader(type, request);
      request.headers[HttpHeaders.accessControlAllowOriginHeader] = '*';
      request.headers[HttpHeaders.accessControlAllowMethodsHeader] =
      'POST, GET, OPTIONS, PUT, DELETE, HEAD';
      if (customHeader != null) {
        for (final entry in customHeader.entries) {
          request.headers[entry.key] = entry.value;
        }
      }

      final shouldPutBodyToRequest = method != 'GET' && data != null;
      if (shouldPutBodyToRequest) {
        final requestBody = data as Map<String, Object?>;
        request.body = jsonEncode(requestBody);
      }

      responseJson = await retry(() async {
        final response = await _client
            .send(request)
            .timeout(const Duration(seconds: 120))
            .then(Response.fromStream);
        return _returnResponse(response);
      }, retryIf: (e) async {
        final url = _getParsedUrl(
            method: method, path: path, params: method == 'GET' ? data : null);
        logger().debug('RETRY >> Call API >> url: $url >> Error: $e');
        if (e is UnauthorisedException) {
          if (numberAttempts == 3) {
            return false;
          }

          final isRefreshSucceed = await _refreshToken();

          if (isRefreshSucceed) {
            request.headers[HttpHeaders.contentTypeHeader] = 'application/json';
            request.headers[HttpHeaders.authorizationHeader] =
                getAuthorizationHeader(type, request);
            request.headers[HttpHeaders.accessControlAllowOriginHeader] = '*';
            request.headers[HttpHeaders.accessControlAllowMethodsHeader] =
            'POST, GET, OPTIONS, PUT, DELETE, HEAD';
            if (customHeader != null) {
              for (final entry in customHeader.entries) {
                request.headers[entry.key] = entry.value;
              }
            }
            final shouldPutBodyToRequest = method != 'GET' && data != null;
            if (shouldPutBodyToRequest) {
              final requestBody = data as Map<String, Object?>;
              request.body = jsonEncode(requestBody);
            }

            numberAttempts += 1;

            return true;
          }

          return false;
        }

        return false;
      });
    } on SocketException {
      logger().debug('No Internet connection');
      throw const SocketException('Operation timed out');
    }

    return responseJson;
  }

  dynamic _returnResponse(Response response) {
    logger().debug('HTTP response\n'
        'Status: ${response.statusCode}\n'
        'Request: ${response.request}\n'
        'Data: ${response.body}');

    switch (response.statusCode) {
      case 200:
        final responseJson = jsonDecode(response.body);
        return responseJson;
      case 201:
        final responseJson = jsonDecode(response.body);
        return responseJson;
      case 204:
        return null;
      case 400:
        final responseJson = jsonDecode(response.body);
        throw BadRequestException(responseJson);
      case 401:
        final responseJson = jsonDecode(response.body);
        throw UnauthorisedException(responseJson);
      case 403:
        final responseJson = jsonDecode(response.body);
        throw ForbiddenException(responseJson);
      case 404:
        final responseJson = jsonDecode(response.body);
        throw NotFoundException(responseJson);
      case 422:
        final responseJson = jsonDecode(response.body);
        throw UnProcessableEntityException(responseJson);
      case 413:
        final responseJson = jsonDecode(payloadTooLargeErrorJson);
        throw PayloadTooLargeException(responseJson);
      case 409:
        final responseJson = jsonDecode(response.body);
        throw ValidationException(responseJson);
      case 500:
        final responseJson = jsonDecode(response.body);
        throw ServerErrorException(responseJson);
      default:
        final responseJson = jsonDecode(defaultErrorJson);
        throw FetchDataException(responseJson);
    }
  }

  static HttpClient getHttpClient(bool trustSelfSigned) {
    final httpClient = HttpClient()
      ..connectionTimeout = const Duration(seconds: 120)
      ..badCertificateCallback =
      ((X509Certificate cert, String host, int port) => trustSelfSigned);

    return httpClient;
  }

  static Future<String> readResponseAsString(HttpClientResponse response) {
    final completer = Completer<String>();
    final contents = StringBuffer();

    response.transform(utf8.decoder).listen(
      contents.write,
      onDone: () => completer.complete(
        contents.toString(),
      ),
    );

    return completer.future;
  }

  Future<dynamic> _uploadFile(String method, String path, FileData data) async {
    final fileStream = data.file.openRead();
    final totalByteLength = data.file.lengthSync();
    final httpClient = getHttpClient(true);

    // ignore: close_sinks
    final request = await httpClient.putUrl(Uri.parse(path));

    request.headers.set(
      HttpHeaders.contentTypeHeader,
      data.type,
    );

    request.headers.add('filename', file_util.basename(data.file.path));

    request.contentLength = totalByteLength;

    var byteCount = 0;

    final streamUpload = fileStream
        .transform(StreamTransformer.fromHandlers(
      handleData: (data, sink) {
        byteCount += data.length;

        // if (onUploadProgress != null) {
        //   onUploadProgress(byteCount, totalByteLength);
        // }

        sink.add(data);
      },
      handleError: (error, stack, sink) {
        logger().debug('Upload >> handleError: ${error.toString()}');
      },
      handleDone: (sink) {
        logger().debug('Upload >> handleDone');
        sink.close();
      },
    ))
        .cast<List<int>>();

    await request.addStream(streamUpload);

    final httpResponse = await request.close();

    if (httpResponse.statusCode != 200) {
      throw Exception('Error uploading file!');
    } else {
      return readResponseAsString(httpResponse);
    }
  }

  dynamic get(String url, ApiHeaderType type,
      {Map<String, String>? customHeader, dynamic data}) async {
    return await _call('GET', url, type,
        customHeader: customHeader, data: data);
  }

  dynamic post(String url, ApiHeaderType type,
      {Map<String, String>? customHeader, dynamic data}) async {
    return await _call('POST', url, type,
        customHeader: customHeader, data: data);
  }

  dynamic put(String url, ApiHeaderType type,
      {Map<String, String>? customHeader, dynamic data}) async {
    if (data.runtimeType == FileData) {
      final fileData = data as FileData;
      return await _uploadFile('PUT', url, fileData);
    }

    return await _call('PUT', url, type,
        customHeader: customHeader, data: data);
  }

  dynamic delete(String url, ApiHeaderType type,
      {Map<String, String>? customHeader, dynamic data}) async {
    return await _call('DELETE', url, type,
        customHeader: customHeader, data: data);
  }

  dynamic patch(String url, ApiHeaderType type,
      {Map<String, String>? customHeader, dynamic data}) async {
    return await _call('PATCH', url, type,
        customHeader: customHeader, data: data);
  }

  @override
  String toString() => 'BaseRemoteDataSource';
}
