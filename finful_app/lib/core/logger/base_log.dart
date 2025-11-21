import 'finful_logger_level.dart';

abstract class BaseLog {
  /// Set initialize level of the logger
  /// All logs with levels below this level will be omitted.
  /// Default is XHRLoggerLevel.trace
  void initialize(FinfulLoggerLevel level);

  /// log for tracking - not in production, should remove all
  void trace(dynamic message);

  /// log for debug - not in production, only for debug purpose
  void debug(dynamic message);

  /// log for event, actions, ...
  void info(dynamic message);

  /// log for unexpected value or data, potential lead to bug
  void warning(dynamic message);

  /// log for try/catch
  void error(dynamic message);

  /// app crash, freeze, ...
  void fatal(dynamic message);
}
