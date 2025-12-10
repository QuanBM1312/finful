import 'package:finful_app/app/presentation/blocs/app_bloc_observe.dart';
import 'package:finful_app/app/presentation/journey/app/root_app.dart';
import 'package:finful_app/core/logger/finful_logger_level.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/injection/injection.dart';
import 'core/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark, // iOS
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
    ),
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  Bloc.observer = AppBlocObserve();
  logger().initialize(FinfulLoggerLevel.debug);

  await Injection().initialize();
  runApp(const RootApp());
}
