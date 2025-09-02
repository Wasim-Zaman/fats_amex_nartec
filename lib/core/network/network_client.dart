import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fats_amex_nartec/core/config/app_config.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';
import 'package:mime/mime.dart';

import 'network_client_model.dart';

enum RequestMethodName { get, post, put, patch, delete }

typedef ProgressCallback = void Function(
    int count, int total, double percentage);

class BaseClient {
  static BaseClient? _instance;
  static BaseClient get instance => _instance ??= BaseClient._internal();

  late final Dio _dio;
  final Logger _logger;
  final String _baseUrl;
  String? _authToken;

  // Progress tracking - using simple double variables
  double uploadProgress = 0.0;
  double downloadProgress = 0.0;

  // Progress tracking streams
  final _uploadProgressController = StreamController<double>.broadcast();
  final _downloadProgressController = StreamController<double>.broadcast();

  Stream<double> get uploadProgressStream => _uploadProgressController.stream;
  Stream<double> get downloadProgressStream =>
      _downloadProgressController.stream;

  BaseClient._internal({
    Dio? dio,
    Duration timeout = const Duration(minutes: 1),
    Logger? logger,
    String? baseUrl,
  })  : _baseUrl = baseUrl ?? AppConfig.baseUrl,
        _logger = logger ??
            Logger(
              printer: PrettyPrinter(
                methodCount: 0,
                errorMethodCount: 3,
                lineLength: 120,
                colors: true,
                printEmojis: true,
              ),
              filter: DevelopmentFilter(),
              output: ConsoleOutput(),
            ) {
    _dio = dio ?? Dio();
    _configureDio(timeout);
  }

  // Factory constructor for custom configuration
  factory BaseClient.configure({
    Dio? dio,
    Duration timeout = const Duration(minutes: 1),
    Logger? logger,
    String? baseUrl,
  }) {
    _instance = BaseClient._internal(
      dio: dio,
      timeout: timeout,
      logger: logger,
      baseUrl: baseUrl,
    );
    return _instance!;
  }

  // Token management methods
  void setAuthToken(String? token) {
    _authToken = token;
  }

  String? getAuthToken() {
    return _authToken;
  }

  void clearAuthToken() {
    _authToken = null;
  }

  void _configureDio(Duration timeout) {
    _dio.options = BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: timeout,
      receiveTimeout: timeout,
      sendTimeout: timeout,
      validateStatus: (status) => true, // Accept all status codes
      responseType: ResponseType.json,
      headers: _getDefaultHeaders(),
    );

    // Add interceptors for logging
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          _logRequest(
            options.uri.toString(),
            options.method,
            options.headers.map((k, v) => MapEntry(k, v.toString())),
            options.data,
          );
          handler.next(options);
        },
        onResponse: (response, handler) {
          _logResponse(response);
          handler.next(response);
        },
        onError: (error, handler) {
          _logError(error);
          handler.next(error);
        },
      ),
    );
  }

  Map<String, String> _getDefaultHeaders() {
    return {'Content-Type': 'application/json', 'Accept': 'application/json'};
  }

  void _logRequest(
    String url,
    String method,
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
      if (body is FormData) {
        final formDataLog = {
          'fields': body.fields.map((e) => '${e.key}: ${e.value}').toList(),
          'files':
              body.files.map((e) => '${e.key}: ${e.value.filename}').toList(),
        };
        requestLog.writeln(
          'BODY (FormData): ${const JsonEncoder.withIndent('  ').convert(formDataLog)}',
        );
      } else {
        final bodyStr = body is String
            ? body
            : const JsonEncoder.withIndent('  ').convert(body);
        requestLog.writeln('BODY: $bodyStr');
      }
    }

    _logger.i(requestLog.toString());
  }

  void _logResponse(Response response) {
    final responseLog = StringBuffer();
    final duration = response.requestOptions.extra['duration'] as Duration?;
    final durationStr =
        duration != null ? ' [${duration.inMilliseconds}ms]' : '';

    responseLog.writeln('\n📨 RESPONSE DETAILS$durationStr');
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
        if (response.data is String) {
          responseLog.writeln('BODY: ${response.data}');
        } else if (response.data is List<int>) {
          responseLog.writeln(
            'BODY: Binary data (${(response.data as List<int>).length} bytes)',
          );
        } else {
          final prettyJson = const JsonEncoder.withIndent(
            '  ',
          ).convert(response.data);
          responseLog.writeln('BODY: $prettyJson');
        }
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

  void _logError(DioException error) {
    final errorLog = StringBuffer();
    errorLog.writeln('\n❌ ERROR DETAILS');
    errorLog.writeln('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    errorLog.writeln('TYPE: ${error.type}');
    errorLog.writeln('MESSAGE: ${error.message}');
    errorLog.writeln('URL: ${error.requestOptions.uri}');

    if (error.response != null) {
      errorLog.writeln('STATUS: ${error.response?.statusCode}');
      errorLog.writeln('DATA: ${error.response?.data}');
    }

    _logger.e(errorLog.toString());
  }

  bool _isPreSignedUrl(String url) {
    return url.contains('X-Amz-Algorithm') ||
        url.contains('X-Amz-Signature') ||
        url.contains('amazonaws.com');
  }

  Map<String, dynamic> _buildHeaders({
    Map<String, String>? headers,
    String? bearerToken,
    bool skipAuth = false,
  }) {
    final defaultHeaders = Map<String, dynamic>.from(_getDefaultHeaders());

    if (!skipAuth) {
      String? tokenToUse = bearerToken ?? _authToken;

      if (tokenToUse != null) {
        defaultHeaders['Authorization'] = 'Bearer $tokenToUse';
      }
    }

    if (headers != null) {
      defaultHeaders.addAll(headers);
    }

    return defaultHeaders;
  }

  String _buildFullUrl(String url, Map<String, String>? pathParams) {
    String finalUrl = url.startsWith('http') ? url : '$_baseUrl$url';

    if (pathParams != null) {
      pathParams.forEach((key, value) {
        finalUrl = finalUrl.replaceAll(':$key', Uri.encodeComponent(value));
      });
    }

    return finalUrl;
  }

  NetworkClientModel _processResponse({
    required Response response,
    required RequestMethodName method,
  }) {
    final statusCode = response.statusCode ?? 0;
    final data = response.data;

    if (statusCode >= 200 && statusCode < 300) {
      _logger.d('🔍 ${method.name.toUpperCase()} parsed data: $data');
      return NetworkClientModel.success(data: data, statusCode: statusCode);
    }

    final message = data is Map<String, dynamic> && data['message'] != null
        ? data['message'] as String
        : 'Request failed with status $statusCode';

    return NetworkClientModel.failure(
      message: message,
      data: data,
      statusCode: statusCode,
    );
  }

  NetworkClientModel _handleDioException(
    DioException error, {
    required RequestMethodName method,
  }) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        _logger.w('⚠️ ${method.name.toUpperCase()} timeout error');
        return const NetworkClientModel.timeoutError();

      case DioExceptionType.connectionError:
        _logger.w('⚠️ ${method.name.toUpperCase()} network error');
        return const NetworkClientModel.networkError();

      case DioExceptionType.badResponse:
        if (error.response != null) {
          return _processResponse(response: error.response!, method: method);
        }
        return NetworkClientModel.unexpectedError(
          message: error.message ?? 'Bad response',
        );

      case DioExceptionType.cancel:
        _logger.w('⚠️ ${method.name.toUpperCase()} request cancelled');
        return const NetworkClientModel.unexpectedError(
          message: 'Request was cancelled',
        );

      default:
        _logger.e(
          '❌ ${method.name.toUpperCase()} unexpected error: ${error.message}',
        );
        return NetworkClientModel.unexpectedError(
          message: error.message ?? 'An unexpected error occurred',
        );
    }
  }

  // Reset progress indicators
  void _resetProgress() {
    uploadProgress = 0.0;
    downloadProgress = 0.0;
    _uploadProgressController.add(0.0);
    _downloadProgressController.add(0.0);
  }

  Future<NetworkClientModel> get(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? pathParams,
    Map<String, String>? queryParams,
    String? bearerToken,
  }) async {
    _resetProgress();

    try {
      final fullUrl = _buildFullUrl(url, pathParams);
      final skipAuth = _isPreSignedUrl(fullUrl);
      final requestHeaders = _buildHeaders(
        headers: headers,
        bearerToken: bearerToken,
        skipAuth: skipAuth,
      );

      final stopwatch = Stopwatch()..start();
      final response = await _dio.get(
        fullUrl,
        queryParameters: queryParams,
        options: Options(
          headers: requestHeaders,
          extra: {'duration': stopwatch.elapsed},
        ),
      );
      stopwatch.stop();

      return _processResponse(
        response: response,
        method: RequestMethodName.get,
      );
    } on DioException catch (e) {
      return _handleDioException(e, method: RequestMethodName.get);
    } catch (e) {
      _logger.e('❌ GET unexpected error: $e');
      return const NetworkClientModel.unexpectedError();
    }
  }

  Future<NetworkClientModel> post(
    String url, {
    Map<String, String>? headers,
    dynamic body,
    Map<String, String>? queryParams,
    Map<String, String>? pathParams,
    String? bearerToken,
    ProgressCallback? onSendProgress,
  }) async {
    _resetProgress();

    try {
      final fullUrl = _buildFullUrl(url, pathParams);
      final skipAuth = _isPreSignedUrl(fullUrl);
      final requestHeaders = _buildHeaders(
        headers: headers,
        bearerToken: bearerToken,
        skipAuth: skipAuth,
      );

      final stopwatch = Stopwatch()..start();
      final response = await _dio.post(
        fullUrl,
        data: body,
        queryParameters: queryParams,
        options: Options(
          headers: requestHeaders,
          extra: {'duration': stopwatch.elapsed},
        ),
        onSendProgress: (count, total) {
          final progress = total > 0 ? count / total : 0.0;
          uploadProgress = progress;
          onSendProgress?.call(count, total, progress);
          _logger.d(
            '📤 Upload progress: ${(progress * 100).toStringAsFixed(1)}%',
          );
        },
      );
      stopwatch.stop();

      return _processResponse(
        response: response,
        method: RequestMethodName.post,
      );
    } on DioException catch (e) {
      return _handleDioException(e, method: RequestMethodName.post);
    } catch (e) {
      _logger.e('❌ POST unexpected error: $e');
      return const NetworkClientModel.unexpectedError();
    }
  }

  Future<NetworkClientModel> postMultipart(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? formFields,
    Map<String, dynamic>? files, // Can be File, Uint8List, or path string
    Map<String, String>? fileNames,
    Map<String, String>? queryParams,
    Map<String, String>? pathParams,
    String? bearerToken,
    ProgressCallback? onSendProgress,
  }) async {
    _resetProgress();

    try {
      final fullUrl = _buildFullUrl(url, pathParams);
      final skipAuth = _isPreSignedUrl(fullUrl);
      final requestHeaders = _buildHeaders(
        headers: headers,
        bearerToken: bearerToken,
        skipAuth: skipAuth,
      );

      // Build FormData
      final formData = FormData();

      // Add form fields
      formFields?.forEach((key, value) {
        formData.fields.add(MapEntry(key, value));
      });

      // Add files
      if (files != null) {
        for (var entry in files.entries) {
          final fieldName = entry.key;
          final file = entry.value;
          final fileName = fileNames?[fieldName] ?? 'file';

          MultipartFile? multipartFile;

          if (file is File) {
            // Handle File
            final mimeType =
                lookupMimeType(file.path) ?? 'application/octet-stream';
            multipartFile = await MultipartFile.fromFile(
              file.path,
              filename: fileName,
              contentType: MediaType.parse(mimeType),
            );
          } else if (file is Uint8List) {
            // Handle Uint8List (for web)
            final mimeType =
                lookupMimeType(fileName) ?? 'application/octet-stream';
            multipartFile = MultipartFile.fromBytes(
              file,
              filename: fileName,
              contentType: MediaType.parse(mimeType),
            );
          } else if (file is String) {
            // Handle file path string
            final mimeType = lookupMimeType(file) ?? 'application/octet-stream';
            multipartFile = await MultipartFile.fromFile(
              file,
              filename: fileName,
              contentType: MediaType.parse(mimeType),
            );
          }

          if (multipartFile != null) {
            formData.files.add(MapEntry(fieldName, multipartFile));
          }
        }
      }

      final stopwatch = Stopwatch()..start();
      final response = await _dio.post(
        fullUrl,
        data: formData,
        queryParameters: queryParams,
        options: Options(
          headers: requestHeaders,
          extra: {'duration': stopwatch.elapsed},
        ),
        onSendProgress: (count, total) {
          final progress = total > 0 ? count / total : 0.0;
          uploadProgress = progress;
          onSendProgress?.call(count, total, progress);
          _logger.d(
            '📤 Upload progress: ${(progress * 100).toStringAsFixed(1)}%',
          );
        },
      );
      stopwatch.stop();

      return _processResponse(
        response: response,
        method: RequestMethodName.post,
      );
    } on DioException catch (e) {
      return _handleDioException(e, method: RequestMethodName.post);
    } catch (e) {
      _logger.e('❌ POST Multipart unexpected error: $e');
      return const NetworkClientModel.unexpectedError();
    }
  }

  Future<NetworkClientModel> put(
    String url, {
    Map<String, String>? headers,
    dynamic body,
    Map<String, String>? pathParams,
    Map<String, String>? queryParams,
    String? bearerToken,
    ProgressCallback? onSendProgress,
  }) async {
    _resetProgress();

    try {
      final fullUrl = _buildFullUrl(url, pathParams);
      final skipAuth = _isPreSignedUrl(fullUrl);
      final requestHeaders = _buildHeaders(
        headers: headers,
        bearerToken: bearerToken,
        skipAuth: skipAuth,
      );

      final stopwatch = Stopwatch()..start();
      final response = await _dio.put(
        fullUrl,
        data: body,
        queryParameters: queryParams,
        options: Options(
          headers: requestHeaders,
          extra: {'duration': stopwatch.elapsed},
        ),
        onSendProgress: (count, total) {
          final progress = total > 0 ? count / total : 0.0;
          uploadProgress = progress;
          onSendProgress?.call(count, total, progress);
          _logger.d(
            '📤 Upload progress: ${(progress * 100).toStringAsFixed(1)}%',
          );
        },
      );
      stopwatch.stop();

      return _processResponse(
        response: response,
        method: RequestMethodName.put,
      );
    } on DioException catch (e) {
      return _handleDioException(e, method: RequestMethodName.put);
    } catch (e) {
      _logger.e('❌ PUT unexpected error: $e');
      return const NetworkClientModel.unexpectedError();
    }
  }

  Future<NetworkClientModel> putMultipart(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? formFields,
    Map<String, dynamic>? files, // Can be File, Uint8List, or path string
    Map<String, String>? fileNames,
    Map<String, String>? queryParams,
    Map<String, String>? pathParams,
    String? bearerToken,
    ProgressCallback? onSendProgress,
  }) async {
    _resetProgress();

    try {
      final fullUrl = _buildFullUrl(url, pathParams);
      final skipAuth = _isPreSignedUrl(fullUrl);
      final requestHeaders = _buildHeaders(
        headers: headers,
        bearerToken: bearerToken,
        skipAuth: skipAuth,
      );

      // Build FormData
      final formData = FormData();

      // Add form fields
      formFields?.forEach((key, value) {
        formData.fields.add(MapEntry(key, value));
      });

      // Add files
      if (files != null) {
        for (var entry in files.entries) {
          final fieldName = entry.key;
          final file = entry.value;
          final fileName = fileNames?[fieldName] ?? 'file';

          MultipartFile? multipartFile;

          if (file is File) {
            // Handle File
            final mimeType =
                lookupMimeType(file.path) ?? 'application/octet-stream';
            multipartFile = await MultipartFile.fromFile(
              file.path,
              filename: fileName,
              contentType: MediaType.parse(mimeType),
            );
          } else if (file is Uint8List) {
            // Handle Uint8List (for web)
            final mimeType =
                lookupMimeType(fileName) ?? 'application/octet-stream';
            multipartFile = MultipartFile.fromBytes(
              file,
              filename: fileName,
              contentType: MediaType.parse(mimeType),
            );
          } else if (file is String) {
            // Handle file path string
            final mimeType = lookupMimeType(file) ?? 'application/octet-stream';
            multipartFile = await MultipartFile.fromFile(
              file,
              filename: fileName,
              contentType: MediaType.parse(mimeType),
            );
          }

          if (multipartFile != null) {
            formData.files.add(MapEntry(fieldName, multipartFile));
          }
        }
      }

      final stopwatch = Stopwatch()..start();
      final response = await _dio.put(
        fullUrl,
        data: formData,
        queryParameters: queryParams,
        options: Options(
          headers: requestHeaders,
          extra: {'duration': stopwatch.elapsed},
        ),
        onSendProgress: (count, total) {
          final progress = total > 0 ? count / total : 0.0;
          uploadProgress = progress;
          onSendProgress?.call(count, total, progress);
          _logger.d(
            '📤 Upload progress: ${(progress * 100).toStringAsFixed(1)}%',
          );
        },
      );
      stopwatch.stop();

      return _processResponse(
        response: response,
        method: RequestMethodName.put,
      );
    } on DioException catch (e) {
      return _handleDioException(e, method: RequestMethodName.put);
    } catch (e) {
      _logger.e('❌ PUT Multipart unexpected error: $e');
      return const NetworkClientModel.unexpectedError();
    }
  }

  Future<NetworkClientModel> patch(
    String url, {
    Map<String, String>? headers,
    dynamic body,
    Map<String, String>? queryParams,
    Map<String, String>? pathParams,
    String? bearerToken,
    ProgressCallback? onSendProgress,
  }) async {
    _resetProgress();

    try {
      final fullUrl = _buildFullUrl(url, pathParams);
      final skipAuth = _isPreSignedUrl(fullUrl);
      final requestHeaders = _buildHeaders(
        headers: headers,
        bearerToken: bearerToken,
        skipAuth: skipAuth,
      );

      final stopwatch = Stopwatch()..start();
      final response = await _dio.patch(
        fullUrl,
        data: body,
        queryParameters: queryParams,
        options: Options(
          headers: requestHeaders,
          extra: {'duration': stopwatch.elapsed},
        ),
        onSendProgress: (count, total) {
          final progress = total > 0 ? count / total : 0.0;
          uploadProgress = progress;
          onSendProgress?.call(count, total, progress);
          _logger.d(
            '📤 Upload progress: ${(progress * 100).toStringAsFixed(1)}%',
          );
        },
      );
      stopwatch.stop();

      return _processResponse(
        response: response,
        method: RequestMethodName.patch,
      );
    } on DioException catch (e) {
      return _handleDioException(e, method: RequestMethodName.patch);
    } catch (e) {
      _logger.e('❌ PATCH unexpected error: $e');
      return const NetworkClientModel.unexpectedError();
    }
  }

  Future<NetworkClientModel> delete(
    String url, {
    Map<String, String>? headers,
    dynamic body,
    Map<String, String>? queryParams,
    Map<String, String>? pathParams,
    String? bearerToken,
  }) async {
    _resetProgress();

    try {
      final fullUrl = _buildFullUrl(url, pathParams);
      final skipAuth = _isPreSignedUrl(fullUrl);
      final requestHeaders = _buildHeaders(
        headers: headers,
        bearerToken: bearerToken,
        skipAuth: skipAuth,
      );

      final stopwatch = Stopwatch()..start();
      final response = await _dio.delete(
        fullUrl,
        data: body,
        queryParameters: queryParams,
        options: Options(
          headers: requestHeaders,
          extra: {'duration': stopwatch.elapsed},
        ),
      );
      stopwatch.stop();

      return _processResponse(
        response: response,
        method: RequestMethodName.delete,
      );
    } on DioException catch (e) {
      return _handleDioException(e, method: RequestMethodName.delete);
    } catch (e) {
      _logger.e('❌ DELETE unexpected error: $e');
      return const NetworkClientModel.unexpectedError();
    }
  }

  // Download file with progress
  Future<NetworkClientModel> downloadFile(
    String url, {
    String? savePath,
    Map<String, String>? headers,
    Map<String, String>? queryParams,
    String? bearerToken,
    ProgressCallback? onReceiveProgress,
    bool returnBytes =
        false, // If true, returns Uint8List instead of saving to file
  }) async {
    _resetProgress();

    try {
      final skipAuth = _isPreSignedUrl(url);
      final requestHeaders = _buildHeaders(
        headers: headers,
        bearerToken: bearerToken,
        skipAuth: skipAuth,
      );

      final stopwatch = Stopwatch()..start();

      if (returnBytes) {
        // Download as bytes
        final response = await _dio.get<List<int>>(
          url,
          queryParameters: queryParams,
          options: Options(
            headers: requestHeaders,
            responseType: ResponseType.bytes,
            extra: {'duration': stopwatch.elapsed},
          ),
          onReceiveProgress: (count, total) {
            final progress = total > 0 ? count / total : 0.0;
            downloadProgress = progress;
            onReceiveProgress?.call(count, total, progress);
            _logger.d(
              '📥 Download progress: ${(progress * 100).toStringAsFixed(1)}%',
            );
          },
        );
        stopwatch.stop();

        if (response.statusCode != null &&
            response.statusCode! >= 200 &&
            response.statusCode! < 300) {
          final bytes = Uint8List.fromList(response.data!);
          _logger.i('✅ Download completed: ${bytes.length} bytes');
          return NetworkClientModel.success(
            data: bytes,
            statusCode: response.statusCode!,
          );
        }

        return NetworkClientModel.failure(
          message: 'Download failed with status ${response.statusCode}',
          statusCode: response.statusCode ?? 0,
        );
      } else {
        // Download to file
        if (savePath == null) {
          return const NetworkClientModel.unexpectedError(
            message: 'Save path is required when not returning bytes',
          );
        }

        final response = await _dio.download(
          url,
          savePath,
          queryParameters: queryParams,
          options: Options(
            headers: requestHeaders,
            extra: {'duration': stopwatch.elapsed},
          ),
          onReceiveProgress: (count, total) {
            final progress = total > 0 ? count / total : 0.0;
            downloadProgress = progress;
            onReceiveProgress?.call(count, total, progress);
            _logger.d(
              '📥 Download progress: ${(progress * 100).toStringAsFixed(1)}%',
            );
          },
        );
        stopwatch.stop();

        if (response.statusCode != null &&
            response.statusCode! >= 200 &&
            response.statusCode! < 300) {
          _logger.i('✅ File downloaded successfully to: $savePath');
          return NetworkClientModel.success(
            data: {'path': savePath},
            statusCode: response.statusCode!,
          );
        }

        return NetworkClientModel.failure(
          message: 'Download failed with status ${response.statusCode}',
          statusCode: response.statusCode ?? 0,
        );
      }
    } on DioException catch (e) {
      return _handleDioException(e, method: RequestMethodName.get);
    } catch (e) {
      _logger.e('❌ Download unexpected error: $e');
      return const NetworkClientModel.unexpectedError();
    }
  }

  // Simplified multipart upload helper
  Future<NetworkClientModel> uploadFile({
    required String url,
    required String fieldName,
    required dynamic file, // File, Uint8List, or String path
    String? fileName,
    Map<String, String>? formFields,
    Map<String, String>? headers,
    String? bearerToken,
    ProgressCallback? onSendProgress,
  }) async {
    return postMultipart(
      url,
      files: {fieldName: file},
      fileNames: fileName != null ? {fieldName: fileName} : null,
      formFields: formFields,
      headers: headers,
      bearerToken: bearerToken,
      onSendProgress: onSendProgress,
    );
  }

  // Batch upload helper
  Future<NetworkClientModel> uploadMultipleFiles({
    required String url,
    required Map<String, dynamic>
        files, // fieldName -> file (File/Uint8List/String)
    Map<String, String>? fileNames,
    Map<String, String>? formFields,
    Map<String, String>? headers,
    String? bearerToken,
    ProgressCallback? onSendProgress,
  }) async {
    return postMultipart(
      url,
      files: files,
      fileNames: fileNames,
      formFields: formFields,
      headers: headers,
      bearerToken: bearerToken,
      onSendProgress: onSendProgress,
    );
  }

  // Cancel all pending requests
  void cancelAllRequests() {
    _dio.close(force: true);
    _logger.w('⚠️ All pending requests cancelled');
  }

  void dispose() {
    _logger.d('🔍 Disposing BaseClient');
    _uploadProgressController.close();
    _downloadProgressController.close();
    _dio.close();
  }
}
