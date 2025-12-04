import 'package:finful_app/app/constants/key/BlocConstants.dart';
import 'package:finful_app/app/domain/interactor/section_interactor.dart';
import 'package:finful_app/app/domain/model/education_model.dart';
import 'package:finful_app/app/presentation/blocs/get_education/get_education.dart';
import 'package:finful_app/core/bloc/base/base_bloc.dart';
import 'package:finful_app/core/bloc/base/bloc_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetEducationBloc extends BaseBloc<GetEducationEvent, GetEducationState> {
  late final SectionInteractor _sectionInteractor;

  GetEducationBloc(Key key, {
    required SectionInteractor sectionInteractor,
  })
      : _sectionInteractor = sectionInteractor,
        super(
        key,
        closeWithBlocKey: BlocConstants.session,
        initialState: GetEducationInitial(
          initOnboardingEducations: <EducationModel>[],
        ),
      ) {
    on<GetEducationOnboardingStarted>(_onGetEducationOnboardingStarted);
  }

  factory GetEducationBloc.instance() {
    return BlocManager().newBloc<GetEducationBloc>(BlocConstants.getEducation);
  }

  Future<void> _onGetEducationOnboardingStarted(
      GetEducationOnboardingStarted event,
      Emitter<GetEducationState> emit,
      ) async {
    emit(GetEducationOnboardingInProgress(state));

    try {
      final data = await _sectionInteractor.getEducation(
          type: event.type,
          location: event.location,
      );
      emit(GetEducationOnboardingSuccess(data));
    } catch (err) {
      emit(GetEducationOnboardingFailure(state));
    }
  }
}