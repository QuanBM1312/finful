
import 'package:finful_app/app/constants/key/BlocConstants.dart';
import 'package:finful_app/core/bloc/base/base_bloc.dart';
import 'package:finful_app/core/bloc/base/bloc_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'show_message_event.dart';
import 'show_message_state.dart';

class ShowMessageBloc extends BaseBloc<ShowMessageEvent, ShowMessageState> {
  ShowMessageBloc(super.key)
      : super(
    initialState: ShowMessageInitial(),
  ) {
    on<ShowMessageSnackBarStarted>(_onShowSnackBarMessage);
    on<ShowMessageToastStarted>(_onShowToastMessage);
  }

  factory ShowMessageBloc.instance() {
    return BlocManager().newBloc<ShowMessageBloc>(BlocConstants.showMessage);
  }

  Future<void> _onShowSnackBarMessage(
      ShowMessageSnackBarStarted event,
      Emitter<ShowMessageState> emit,
      ) async {
    emit(ShowMessageSnackBarStartedInProgress());
    emit(
      ShowMessageSnackBarStartedSuccess(
        type: event.type,
        title: event.title,
        message: event.message,
      ),
    );
  }

  Future<void> _onShowToastMessage(
      ShowMessageToastStarted event,
      Emitter<ShowMessageState> emit,
      ) async {
    emit(ShowMessageToastStartedInProgress());
    emit(
      ShowMessageToastStartedSuccess(
        title: event.title,
        message: event.message,
      ),
    );
  }
}
