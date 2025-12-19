import 'package:finful_app/app/data/datasource/remote/expert_remote_datasource.dart';
import 'package:finful_app/app/data/model/request/booking_request.dart';
import 'package:finful_app/app/data/model/request/chat_request.dart';
import 'package:finful_app/app/data/model/response/booking_response.dart';
import 'package:finful_app/app/data/model/response/chat_response.dart';
import 'package:finful_app/app/data/repository/expert_repository.dart';

class ExpertRepositoryImpl implements ExpertRepository {
  late final ExpertRemoteDatasource _expertRemoteDatasource;

  ExpertRepositoryImpl({
    required ExpertRemoteDatasource expertRemoteDatasource,
  }) : _expertRemoteDatasource = expertRemoteDatasource;

  @override
  Future<BookingResponse> requestBooking({
    required BookingRequest request,
  }) async {
    final response = await _expertRemoteDatasource.postBooking(
        request: request,
    );
    return response;
  }

  @override
  Future<ChatResponse> requestChat({
    required ChatRequest request,
  }) async {
    final response = await _expertRemoteDatasource.postChat(
      request: request,
    );
    return response;
  }
}