import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LogsService {
  static final LogsService _instance = LogsService._internal();
  factory LogsService() => _instance;
  LogsService._internal();

  final _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 3,
      lineLength: 120,
      colors: true,
      printEmojis: true,
    ),
    filter: DevelopmentFilter(),
    output: ConsoleOutput(),
  );

  void logRequest(
    String method,
    String url,
    Map<String, String> headers,
    dynamic body,
  ) {
    final requestLog = StringBuffer();
    requestLog.writeln('\n🌐 REQUEST DETAILS');
    requestLog.writeln('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    requestLog.writeln('URL: $url');
    requestLog.writeln('METHOD: $method');
    requestLog.writeln(
      'HEADERS: ${const JsonEncoder.withIndent('  ').convert(headers)}',
    );

    if (body != null) {
      final bodyStr = body is String
          ? body
          : const JsonEncoder.withIndent('  ').convert(body);
      requestLog.writeln('BODY: $bodyStr');
    }

    _logger.i(requestLog.toString());
  }

  void logResponse(Response response, Duration duration) {
    final responseLog = StringBuffer();
    responseLog.writeln('\n📨 RESPONSE DETAILS [${duration.inMilliseconds}ms]');
    responseLog.writeln('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    responseLog.writeln('STATUS: ${response.statusCode}');
    responseLog.writeln('URL: ${response.requestOptions.uri}');

    if (response.headers.map.isNotEmpty) {
      responseLog.writeln(
        'HEADERS: ${const JsonEncoder.withIndent('  ').convert(response.headers.map)}',
      );
    }

    if (response.data != null) {
      try {
        final prettyJson =
            const JsonEncoder.withIndent('  ').convert(response.data);
        responseLog.writeln('BODY: $prettyJson');
      } catch (e) {
        responseLog.writeln('BODY: ${response.data}');
      }
    }

    final icon = response.statusCode != null &&
            response.statusCode! >= 200 &&
            response.statusCode! < 300
        ? '✅'
        : '❌';
    _logger.i('$icon ${responseLog.toString()}');
  }

  void logCache(String action, String endpoint) {
    switch (action.toLowerCase()) {
      case 'hit':
        _logger.i('📦 Cache Hit: $endpoint');
        break;
      case 'miss':
        _logger.i('🔍 Cache Miss: $endpoint');
        break;
      case 'store':
        _logger.i('💾 Cache Stored: $endpoint');
        break;
      case 'clear':
        _logger.i('🧹 Cache Cleared');
        break;
      default:
        _logger.i('🔄 Cache Operation ($action): $endpoint');
    }
  }

  void logWarning(String message) {
    _logger.w('⚠️ $message');
  }

  void logError(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e('❌ $message', error: error, stackTrace: stackTrace);
  }

  void logInfo(String message) {
    _logger.i('ℹ️ $message');
  }

  void logDebug(String message) {
    _logger.d('🔍 $message');
  }

  void logVerbose(String message) {
    _logger.v('📝 $message');
  }

  void logDioError(DioException error) {
    final errorLog = StringBuffer();
    errorLog.writeln('\n❌ DIO ERROR');
    errorLog.writeln('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    errorLog.writeln('TYPE: ${error.type}');
    errorLog.writeln('URL: ${error.requestOptions.uri}');
    errorLog.writeln('METHOD: ${error.requestOptions.method}');

    if (error.response != null) {
      errorLog.writeln('STATUS: ${error.response?.statusCode}');
      if (error.response?.data != null) {
        try {
          final prettyJson =
              const JsonEncoder.withIndent('  ').convert(error.response?.data);
          errorLog.writeln('RESPONSE: $prettyJson');
        } catch (e) {
          errorLog.writeln('RESPONSE: ${error.response?.data}');
        }
      }
    }

    errorLog.writeln('MESSAGE: ${error.message}');
    _logger.e(errorLog.toString(), error: error, stackTrace: error.stackTrace);
  }
}
