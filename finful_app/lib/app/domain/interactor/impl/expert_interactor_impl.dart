import 'package:finful_app/app/data/model/request/booking_request.dart';
import 'package:finful_app/app/data/model/request/chat_request.dart';
import 'package:finful_app/app/data/repository/expert_repository.dart';
import 'package:finful_app/app/domain/interactor/expert_interactor.dart';

class ExpertInteractorImpl implements ExpertInteractor {
  late final ExpertRepository _expertRepository;

  ExpertInteractorImpl({
    required ExpertRepository expertRepository,
  }) : _expertRepository = expertRepository;

  @override
  Future<void> submitRequestBooking({
    required String name,
    required String phoneNumber,
  }) async {
    final request = BookingRequest(
        phoneNumber: phoneNumber,
        name: name,
    );
    await _expertRepository.requestBooking(
      request: request,
    );
  }

  @override
  Future<void> submitRequestChat({
    required String phoneNumber,
  }) async {
    final request = ChatRequest(
      phoneNumber: phoneNumber,
    );
    await _expertRepository.requestChat(
      request: request,
    );
  }

}