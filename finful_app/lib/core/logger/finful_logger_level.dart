import 'package:logger/logger.dart';

enum FinfulLoggerLevel {
  trace,
  debug,
  info,
  warning,
  none,
  error,
}

extension FinfulLoggerLevelExt on FinfulLoggerLevel {
  Level get loggerLevel {
    switch (this) {
      case FinfulLoggerLevel.trace:
        return Level.trace;
      case FinfulLoggerLevel.debug:
        return Level.debug;
      case FinfulLoggerLevel.info:
        return Level.info;
      case FinfulLoggerLevel.warning:
        return Level.warning;
      case FinfulLoggerLevel.error:
        return Level.error;
      case FinfulLoggerLevel.none:
        return Level.off;
    }
  }
}
