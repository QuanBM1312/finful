import 'package:finful_app/app/data/model/request/booking_request.dart';
import 'package:finful_app/app/data/model/request/chat_request.dart';
import 'package:finful_app/app/data/model/response/booking_response.dart';
import 'package:finful_app/app/data/model/response/chat_response.dart';
abstract interface class ExpertRepository {
  Future<ChatResponse> requestChat({
    required ChatRequest request,
  });

  Future<BookingResponse> requestBooking({
    required BookingRequest request,
  });
}