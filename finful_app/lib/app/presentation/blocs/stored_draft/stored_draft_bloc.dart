import 'package:finful_app/app/constants/key/BlocConstants.dart';
import 'package:finful_app/app/presentation/blocs/mixins/loader_bloc_mixin.dart';
import 'package:finful_app/app/presentation/blocs/mixins/show_message_mixin.dart';
import 'package:finful_app/app/presentation/blocs/stored_draft/stored_draft_event.dart';
import 'package:finful_app/app/presentation/blocs/stored_draft/stored_draft_state.dart';
import 'package:finful_app/core/bloc/base/base_bloc.dart';
import 'package:finful_app/core/bloc/base/bloc_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoredDraftBloc extends BaseBloc<StoredDraftEvent, StoredDraftState>
    with LoaderBlocMixin, ShowMessageBlocMixin {

  StoredDraftBloc(super.key) :super(
    initialState: StoredDraftInitial(
      initOnboardingDraftData: null,
    ),
  ) {
    on<StoredDraftClearOnboardingDataStarted>(_onStoredDraftClearOnboardingDataStarted);
    on<StoredDraftUpdateOnboardingDataStarted>(_onStoredDraftUpdateOnboardingDataStarted);
  }

  factory StoredDraftBloc.instance() {
    return BlocManager().newBloc<StoredDraftBloc>(BlocConstants.storedDraft);
  }

  Future<void> _onStoredDraftClearOnboardingDataStarted(
      StoredDraftClearOnboardingDataStarted event,
      Emitter<StoredDraftState> emit,
      ) async {
    emit(StoredDraftClearOnboardingDataSuccess());
  }

  Future<void> _onStoredDraftUpdateOnboardingDataStarted(
      StoredDraftUpdateOnboardingDataStarted event,
      Emitter<StoredDraftState> emit,
      ) async {
    emit(StoredDraftUpdateOnboardingDataSuccess(
      onboardingAnswersDraft: event.onboardingAnswers,
    ));
  }
}