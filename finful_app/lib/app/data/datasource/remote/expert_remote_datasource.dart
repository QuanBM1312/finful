import 'package:finful_app/app/data/model/request/booking_request.dart';
import 'package:finful_app/app/data/model/request/chat_request.dart';
import 'package:finful_app/app/data/model/response/booking_response.dart';
import 'package:finful_app/app/data/model/response/chat_response.dart';

abstract interface class ExpertRemoteDatasource {
  Future<ChatResponse> postChat({
    required ChatRequest request,
  });

  Future<BookingResponse> postBooking({
    required BookingRequest request,
  });
}