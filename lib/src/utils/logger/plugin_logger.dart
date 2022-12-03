import 'dart:io';

import 'package:analyzer_plugin/channel/channel.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:data_class_plugin/src/utils/logger/ansi.dart';
import 'package:data_class_plugin/src/utils/logger/console_logger.dart';
import 'package:data_class_plugin/src/utils/logger/file_logger.dart';
import 'package:data_class_plugin/src/utils/logger/logger.dart';
import 'package:data_class_plugin/src/utils/logger/mock_logger.dart';
import 'package:stack_trace/stack_trace.dart';

class PluginLogger extends Logger {
  PluginLogger({
    final IOSink? ioSink,
    final bool writeToFile = false,
  })  : _consoleLogger = ConsoleLogger(ioSink),
        _fileLogger = writeToFile ? FileLogger() : MockLogger();

  final ConsoleLogger _consoleLogger;
  final Logger _fileLogger;

  PluginCommunicationChannel? _channel;
  set channel(final PluginCommunicationChannel value) {
    _channel = value;
  }

  @override
  void write([final Object? object]) {
    _consoleLogger.write(object);
    _fileLogger.write(object);
  }

  @override
  void writeln([final Object? object]) {
    _consoleLogger.writeln(object);
    _fileLogger.writeln(object);
  }

  @override
  void info([final Object? object]) {
    _consoleLogger.info(object);
    _fileLogger.info(object);
  }

  @override
  void warning([final Object? object]) {
    _consoleLogger.warning(object);
    _fileLogger.warning(object);
  }

  @override
  void error(
    final Object? error, [
    final StackTrace? st,
    final bool isFatal = false,
  ]) {
    _consoleLogger.error(error, st, isFatal);
    _fileLogger.error(error, st, isFatal);
  }

  @override
  void exception(
    final Object? error, [
    final StackTrace? st,
    final bool isFatal = false,
  ]) {
    final StackTrace stackTrace = st ?? Trace(<Frame>[Trace.current(1).frames[0]]);

    _consoleLogger.exception(error, stackTrace, isFatal);
    _fileLogger.exception(error, stackTrace, isFatal);

    _channel!.sendNotification(
      PluginErrorParams(
        isFatal,
        'An exception was thrown: $error',
        stackTrace.toString(),
      ).toNotification(),
    );
  }

  void notification(final Object message) {
    info(message);

    // TODO: Replace PluginErrorParams
    // https://github.com/JetBrains/intellij-plugins/blob/master/Dart/resources/messages/DartBundle.properties
    //
    _channel?.sendNotification(
      PluginErrorParams(
        false,
        '$message',
        '',
      ).toNotification(),
    );

    // _channel!.sendNotification(
    //   AnalysisErrorsParams('', <AnalysisError>[
    //     AnalysisError(
    //       AnalysisErrorSeverity.INFO,
    //       AnalysisErrorType.HINT,
    //       Location('', 0, 1, 1, 1),
    //       '$message',
    //       'code',
    //     )
    //   ]).toNotification(),
    // );
  }

  void showAnalysisHint(
    final String path,
    final String message, {
    final String? code,
    final Location? location,
    final List<DiagnosticMessage>? messages,
    final String? url,
  }) {
    showAnalysisMessage(
      path,
      message,
      severity: AnalysisErrorSeverity.INFO,
      type: AnalysisErrorType.HINT,
      messages: messages,
      url: url,
      code: code,
      location: location,
    );
  }

  void showAnalysisWarning(
    final String path,
    final String message, {
    final String? code,
    final Location? location,
    final List<DiagnosticMessage>? messages,
    final String? url,
  }) {
    showAnalysisMessage(
      path,
      message,
      severity: AnalysisErrorSeverity.WARNING,
      type: AnalysisErrorType.STATIC_WARNING,
      messages: messages,
      url: url,
      code: code,
      location: location,
    );
  }

  void showAnalysisError(
    final String path,
    final String message, {
    final String? code,
    final Location? location,
    final List<DiagnosticMessage>? messages,
    final String? url,
  }) {
    showAnalysisMessage(
      path,
      message,
      severity: AnalysisErrorSeverity.ERROR,
      type: AnalysisErrorType.COMPILE_TIME_ERROR,
      messages: messages,
      url: url,
      code: code,
      location: location,
    );
  }

  void showAnalysisMessage(
    final String path,
    final String message, {
    required final AnalysisErrorSeverity severity,
    required final AnalysisErrorType type,
    final String? code,
    final Location? location,
    final List<DiagnosticMessage>? messages,
    final String? url,
  }) {
    final Location defaultLocation = location ?? Location(path, 0, 1, 1, 1);

    _channel!.sendNotification(
      AnalysisErrorsParams(path, <AnalysisError>[
        AnalysisError(
          severity,
          type,
          defaultLocation,
          message,
          code ?? 'data_class_plugin',
          contextMessages: messages,
          url: url,
        )
      ]).toNotification(),
    );
  }

  @override
  void logHeader(
    final String title, {
    final String? subtitle,
    final LineStyle lineStyle = LineStyle.single,
    final int lineLength = 50,
  }) {
    _consoleLogger.logHeader(
      title,
      subtitle: subtitle,
      lineStyle: lineStyle,
      lineLength: lineLength,
    );

    _fileLogger.logHeader(
      title,
      subtitle: subtitle,
      lineStyle: lineStyle,
      lineLength: lineLength,
    );
  }

  @override
  Future<void> dispose() async {
    await _consoleLogger.dispose();
    await _fileLogger.dispose();
  }
}
