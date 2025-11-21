import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/bloc/base/base_bloc.dart';
import '../../../../../core/bloc/base/bloc_manager.dart';
import '../../../../constants/key/BlocConstants.dart';
import 'loader_event.dart';
import 'loader_state.dart';

class LoaderBloc extends BaseBloc<LoaderEvent, LoaderState> {
  LoaderBloc(super.key)
      : super(
    initialState: LoaderInitial(),
  ) {
    on<LoaderStarted>(_onLoaderStarted);
    on<LoaderStopped>(_onLoaderStopped);
  }

  factory LoaderBloc.instance() {
    return BlocManager().newBloc<LoaderBloc>(BlocConstants.loader);
  }

  Future<void> _onLoaderStarted(
      LoaderStarted event,
      Emitter<LoaderState> emit,
      ) async {
    if (state is! LoaderStartSuccess) {
      emit(LoaderStartSuccess());
    }
  }

  Future<void> _onLoaderStopped(
      LoaderStopped event,
      Emitter<LoaderState> emit,
      ) async {
    if (state is! LoaderStopSuccess) {
      emit(LoaderStopSuccess());
    }
  }
}
