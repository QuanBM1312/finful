import 'package:finful_app/app/data/datasource/remote/expert_remote_datasource.dart';
import 'package:finful_app/app/data/model/request/booking_request.dart';
import 'package:finful_app/app/data/model/request/chat_request.dart';
import 'package:finful_app/app/data/model/response/booking_response.dart';
import 'package:finful_app/app/data/model/response/chat_response.dart';
import 'package:finful_app/core/datasource/base_remote.dart';
import 'package:finful_app/core/datasource/config.dart';

class ExpertRemoteDatasourceImpl extends BaseRemote implements ExpertRemoteDatasource {
  late final String _host;

  ExpertRemoteDatasourceImpl({
    required String host,
    required super.config,
    super.getAuthorization,
  })  : _host = host;

  @override
  Future<BookingResponse> postBooking({
    required BookingRequest request,
  }) async {
    final url = '$_host/expert/booking';
    final json = await post(url, ApiHeaderType.withToken, data: request.toJson());
    return BookingResponse.fromJson(json);
  }

  @override
  Future<ChatResponse> postChat({
    required ChatRequest request,
  }) async {
    final url = '$_host/expert/chat';
    final json = await post(url, ApiHeaderType.withToken, data: request.toJson());
    return ChatResponse.fromJson(json);
  }


}