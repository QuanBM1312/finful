import 'package:finful_app/app/constants/key/BlocConstants.dart';
import 'package:finful_app/app/domain/interactor/expert_interactor.dart';
import 'package:finful_app/app/presentation/blocs/mixins/loader_bloc_mixin.dart';
import 'package:finful_app/app/presentation/blocs/mixins/session_bloc_mixin.dart';
import 'package:finful_app/app/presentation/blocs/mixins/show_message_mixin.dart';
import 'package:finful_app/core/bloc/base/base_bloc.dart';
import 'package:finful_app/core/bloc/base/bloc_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'request_booking_event.dart';
import 'request_booking_state.dart';

class RequestBookingBloc extends BaseBloc<RequestBookingEvent, RequestBookingState>
    with LoaderBlocMixin, ShowMessageBlocMixin, SessionBlocMixin {
  late final ExpertInteractor _expertInteractor;

  RequestBookingBloc(Key key, {
    required ExpertInteractor expertInteractor,
  })
      : _expertInteractor = expertInteractor,
        super(
        key,
        initialState: RequestBookingInitial(),
      ) {
    on<RequestBookingStarted>(_onRequestBookingStarted);
  }

  factory RequestBookingBloc.instance() {
    return BlocManager().newBloc<RequestBookingBloc>(BlocConstants.requestBooking);
  }

  Future<void> _onRequestBookingStarted(
      RequestBookingStarted event,
      Emitter<RequestBookingState> emit,
      ) async {
    showAppLoading();
    emit(RequestBookingInProgress());

    try {
      await _expertInteractor.submitRequestBooking(
          name: event.name,
          phoneNumber: event.phoneNumber,
      );
      emit(RequestBookingSuccess());
    } catch (error) {
      handleError(error);
      emit(RequestBookingFailure());
    } finally {
      hideAppLoading();
    }
  }
}