import 'package:finful_app/app/constants/key/BlocConstants.dart';
import 'package:finful_app/app/domain/interactor/expert_interactor.dart';
import 'package:finful_app/app/presentation/blocs/mixins/loader_bloc_mixin.dart';
import 'package:finful_app/app/presentation/blocs/mixins/session_bloc_mixin.dart';
import 'package:finful_app/app/presentation/blocs/mixins/show_message_mixin.dart';
import 'package:finful_app/core/bloc/base/base_bloc.dart';
import 'package:finful_app/core/bloc/base/bloc_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'request_chat_event.dart';
import 'request_chat_state.dart';

class RequestChatBloc extends BaseBloc<RequestChatEvent, RequestChatState>
    with LoaderBlocMixin, ShowMessageBlocMixin, SessionBlocMixin {
  late final ExpertInteractor _expertInteractor;

  RequestChatBloc(Key key, {
    required ExpertInteractor expertInteractor,
  })
      : _expertInteractor = expertInteractor,
        super(
        key,
        initialState: RequestChatInitial(),
      ) {
    on<RequestChatStarted>(_onRequestChatStarted);
  }

  factory RequestChatBloc.instance() {
    return BlocManager().newBloc<RequestChatBloc>(BlocConstants.requestChat);
  }

  Future<void> _onRequestChatStarted(
      RequestChatStarted event,
      Emitter<RequestChatState> emit,
      ) async {
    showAppLoading();
    emit(RequestChatInProgress());

    try {
      await _expertInteractor.submitRequestChat(
        phoneNumber: event.phoneNumber,
      );
      emit(RequestChatSuccess());
    } catch (error) {
      handleError(error);
      emit(RequestChatFailure());
    } finally {
      hideAppLoading();
    }
  }
}