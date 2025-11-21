import 'package:logger/logger.dart';

import 'base_log.dart';
import 'finful_log_printer.dart';
import 'finful_logger_level.dart';

class LogImpl implements BaseLog {
  static final LogImpl _instance = LogImpl._();

  factory LogImpl() {
    return _instance;
  }

  LogImpl._();

  late Logger _logger;

  @override
  void debug(dynamic message) {
    _logger.d(message);
  }

  @override
  void error(dynamic message) {
    _logger.e(message);
  }

  @override
  void fatal(dynamic message) {
    _logger.f(message);
  }

  @override
  void info(dynamic message) {
    _logger.i(message);
  }

  @override
  void trace(dynamic message) {
    _logger.t(message);
  }

  @override
  void warning(dynamic message) {
    _logger.w(message);
  }

  @override
  void initialize(FinfulLoggerLevel level) {
    Logger.level = level.loggerLevel;
    _logger = Logger(
      printer: FinFulLogPrinter(
        methodCount: 2, // number of method calls to be displayed
        errorMethodCount: 8, // number of method calls if stacktrace is provided
        lineLength: 120, // width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        printTime: true, // Should each log print contain a timestamp
      ),
    );
  }
}
