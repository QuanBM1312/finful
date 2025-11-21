
import 'package:finful_app/app/constants/key/BlocConstants.dart';
import 'package:finful_app/core/bloc/base/bloc_manager.dart';

import '../common/loader/loader.dart';

mixin LoaderBlocMixin {
  void showAppLoading() {
    BlocManager().event<LoaderBloc>(
      BlocConstants.loader,
      LoaderStarted(),
    );
  }

  void hideAppLoading() {
    BlocManager().event<LoaderBloc>(
      BlocConstants.loader,
      LoaderStopped(),
    );
  }
}
