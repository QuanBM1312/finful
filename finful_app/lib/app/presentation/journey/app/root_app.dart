import 'package:finful_app/app/constants/route.dart';
import 'package:finful_app/app/presentation/blocs/common/connectivity/connectivity_bloc.dart';
import 'package:finful_app/app/presentation/blocs/common/connectivity/connectivity_event.dart';
import 'package:finful_app/app/presentation/blocs/common/loader/loader_bloc.dart';
import 'package:finful_app/app/presentation/blocs/common/loader/loader_state.dart';
import 'package:finful_app/app/presentation/blocs/common/session/session_bloc.dart';
import 'package:finful_app/app/presentation/blocs/common/session/session_event.dart';
import 'package:finful_app/app/presentation/blocs/common/show_message/show_message.dart';
import 'package:finful_app/app/presentation/blocs/stored_draft/stored_draft_bloc.dart';
import 'package:finful_app/app/presentation/blocs/stored_draft/stored_draft_state.dart';
import 'package:finful_app/app/presentation/widgets/app_loading/finful_loading.dart';
import 'package:finful_app/app/presentation/widgets/app_snackbar/finful_snack_bar.dart';
import 'package:finful_app/app/routes/app_routes.dart';
import 'package:finful_app/app/theme/theme.dart';
import 'package:finful_app/core/localization/l10n.dart';
import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class RootApp extends StatefulWidget {
  const RootApp({super.key});

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  @override
  void initState() {
    super.initState();
    clearDiskCachedImages(duration: const Duration(days: 7));
  }


  void _showMessageStateListener(
      BuildContext context,
      ShowMessageState state,
      ) {
    switch (state.runtimeType) {
      case ShowMessageSnackBarStartedSuccess:
        final _state = state as ShowMessageSnackBarStartedSuccess;
        switch (_state.type) {
          case ShowMessageSnackBarType.info:
            return FinfulSnackBar.info(
              title: L10n.of(context).translate(_state.title ?? ''),
              message: L10n.of(context).translate(_state.message ?? ''),
            );
          case ShowMessageSnackBarType.warning:
            return FinfulSnackBar.warning(
              title: L10n.of(context).translate(_state.title ?? ''),
              message: L10n.of(context).translate(_state.message ?? ''),
            );
          case ShowMessageSnackBarType.error:
            return FinfulSnackBar.error(
              title: L10n.of(context).translate(_state.title ?? ''),
              message: L10n.of(context).translate(_state.message ?? ''),
            );
        }
      default:
    }
  }

  List<BlocProvider> _registerBlocProviders() {
    return <BlocProvider>[
      BlocProvider<LoaderBloc>(create: (_) => LoaderBloc.instance()),
      BlocProvider<ConnectivityBloc>(
        create: (_) => ConnectivityBloc.instance()..add(ConnectivityChecked())),
      BlocProvider<SessionBloc>(
          create: (_) => SessionBloc.instance()..add(SessionLoaded())),
      BlocProvider<ShowMessageBloc>(
          create: (_) => ShowMessageBloc.instance()),
      BlocProvider<StoredDraftBloc>(
          create: (_) => StoredDraftBloc.instance()),
    ];
  }

  List<Locale> _supportedLocales() {
    return const [
      Locale('vi'),
      Locale('en'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: _registerBlocProviders(),
        child: MaterialApp(
          themeMode: ThemeMode.dark,
          theme: FinfulTheme.light(),
          darkTheme: FinfulTheme.dark(),
          initialRoute: RouteConstant.splash,
          navigatorKey: AppRoutes.shared.navigatorKey,
          onGenerateRoute: AppRoutes.shared.generateRoute,
          locale: const Locale('vi'),
          supportedLocales: _supportedLocales(),
          localizationsDelegates: [
            L10nDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          builder: (context, widget) {
            return BlocBuilder<LoaderBloc, LoaderState>(
              builder: (context, state) {
                return MultiBlocListener(
                  listeners: [
                    BlocListener<ShowMessageBloc, ShowMessageState>(
                      listener: _showMessageStateListener,
                    ),
                    BlocListener<StoredDraftBloc, StoredDraftState>(
                      listener: (_, state) {},
                    ),
                  ],
                  child: Stack(
                    children: [
                      FinfulLoading(
                        isLoading: state is LoaderStartSuccess,
                        indicatorColor: FinfulColor.yellow,
                        backgroundColor: Colors.black.withValues(alpha: 0.5),
                        loadingLabel:
                        L10n.of(context).translate('common_loading'),
                        labelStyle:
                        Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: FinfulColor.brandPrimary,
                        ),
                        child: widget,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
    );
  }
}
