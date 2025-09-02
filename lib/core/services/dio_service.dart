// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// import '../../view/screens/auth/login_screen.dart';
// import '../config/app_config.dart';
// import '../utils/navigation_util.dart';
// import 'dio_logs_service.dart';
// import 'storage_service.dart';

// enum HttpMethod {
//   get,
//   post,
//   put,
//   delete,
//   patch,
// }

// class DioService {
//   // Status codes for token expiry
//   static const int accessTokenExpiredCode = 419;
//   static const int refreshTokenExpiredCode = 420;

//   final String _baseUrl;
//   bool _isRefreshing = false;
//   final StorageService _storage = StorageService();
//   final LogsService _logger = LogsService();
//   final Dio _dio = Dio();
//   final Map<String, dynamic> _cache = {};

//   DioService({String? baseUrl}) : _baseUrl = baseUrl ?? AppConfig.baseUrl {
//     _initializeDio();
//   }

//   void _initializeDio() {
//     _dio.options.baseUrl = _baseUrl;
//     _dio.options.connectTimeout = const Duration(seconds: 30);
//     _dio.options.receiveTimeout = const Duration(seconds: 30);
//   }

//   // Headers with Authorization
//   Future<Map<String, String>> _getHeaders() async {
//     final accessToken = await _storage.getAccessToken();
//     return {
//       'Content-Type': 'application/json',
//       if (accessToken != null) 'Authorization': 'Bearer $accessToken',
//     };
//   }

//   // Refresh Token Logic
//   Future<bool> _refreshTokens() async {
//     if (_isRefreshing) return false;

//     try {
//       _isRefreshing = true;
//       final refreshToken = await _storage.getRefreshToken();

//       if (refreshToken == null) {
//         return false;
//       }

//       final response = await request(
//         '/v1/user/refresh-token',
//         method: HttpMethod.post,
//         data: {'refreshToken': refreshToken},
//       );

//       if (response.statusCode == 200) {
//         final data = response.data;
//         await _storage.saveTokens(
//           accessToken: data['data']['accessToken'],
//           refreshToken: data['data']['refreshToken'],
//         );
//         return true;
//       }

//       return false;
//     } catch (e) {
//       return false;
//     } finally {
//       _isRefreshing = false;
//     }
//   }

//   // Handle Unauthorized Access
//   void _handleUnauthorized(BuildContext context) async {
//     await _storage.clearTokens();
//     if (context.mounted) {
//       NavigationUtil.pushAndRemoveUntil(context, const LoginScreen());
//     }
//   }

//   // Clear cache
//   void clearCache() {
//     _cache.clear();
//     _logger.logInfo('Cache cleared!');
//   }

//   // Main Request Method
//   Future<Response> request(
//     String endpoint, {
//     HttpMethod method = HttpMethod.get,
//     dynamic data,
//     BuildContext? context,
//     Map<String, String>? additionalHeaders,
//     Map<String, String>? queryParameters,
//   }) async {
//     final headers = await _getHeaders();
//     if (additionalHeaders != null) {
//       headers.addAll(additionalHeaders);
//     }

//     Stopwatch? stopwatch;

//     if (kDebugMode) {
//       stopwatch = Stopwatch()..start();
//       _logger.logRequest(
//         method.toString().split('.').last.toUpperCase(),
//         '$_baseUrl$endpoint',
//         headers,
//         data,
//       );
//     }

//     // Check cache for GET requests
//     if (method == HttpMethod.get && _cache.containsKey(endpoint)) {
//       if (kDebugMode) {
//         _logger.logInfo('📦 Returning cached data for $endpoint');
//       }
//       return Response(
//         requestOptions: RequestOptions(path: endpoint),
//         data: _cache[endpoint],
//         statusCode: 200,
//       );
//     }

//     Response response = await _performRequest(
//       endpoint,
//       method,
//       headers: headers,
//       data: data,
//     );

//     if (stopwatch != null) {
//       stopwatch.stop();
//       _logger.logResponse(response, stopwatch.elapsed);
//     }

//     // Handle Access Token Expiry
//     if (response.statusCode == accessTokenExpiredCode) {
//       if (kDebugMode) {
//         _logger.logWarning('🔄 Token expired, attempting refresh...');
//       }

//       final refreshSuccess = await _refreshTokens();
//       if (refreshSuccess) {
//         if (kDebugMode) {
//           _logger.logInfo('🔑 Token refresh successful, retrying request...');
//         }

//         final newHeaders = await _getHeaders();
//         response = await _performRequest(
//           endpoint,
//           method,
//           headers: newHeaders,
//           data: data,
//         );

//         if (stopwatch != null) {
//           stopwatch.stop();
//           _logger.logResponse(response, stopwatch.elapsed);
//         }
//       } else if (context != null && context.mounted) {
//         if (kDebugMode) {
//           _logger.logError('❌ Token refresh failed');
//         }
//         _handleUnauthorized(context);
//         throw DioException(
//           requestOptions: RequestOptions(path: endpoint),
//           message: 'Session expired. Please login again.',
//         );
//       }
//     }

//     // Handle Refresh Token Expiry
//     if (response.statusCode == refreshTokenExpiredCode &&
//         context != null &&
//         context.mounted) {
//       if (kDebugMode) {
//         _logger.logError('🚫 Refresh token expired');
//       }
//       _handleUnauthorized(context);
//       throw DioException(
//         requestOptions: RequestOptions(path: endpoint),
//         message: 'Session expired. Please login again.',
//       );
//     }

//     // Cache successful GET responses
//     if (method == HttpMethod.get &&
//         response.statusCode == 200 &&
//         response.data != null) {
//       if (kDebugMode) {
//         _logger.logInfo('💾 Cached data for $endpoint');
//       }
//       _cache[endpoint] = response.data;
//     }

//     return response;
//   }

//   // Perform HTTP Request
//   Future<Response> _performRequest(
//     String endpoint,
//     HttpMethod method, {
//     Map<String, String>? headers,
//     dynamic data,
//   }) async {
//     final options = Options(headers: headers);

//     try {
//       switch (method) {
//         case HttpMethod.get:
//           return await _dio.get(endpoint, options: options);
//         case HttpMethod.post:
//           return await _dio.post(endpoint, data: data, options: options);
//         case HttpMethod.put:
//           return await _dio.put(endpoint, data: data, options: options);
//         case HttpMethod.delete:
//           return await _dio.delete(endpoint, options: options);
//         case HttpMethod.patch:
//           return await _dio.patch(endpoint, data: data, options: options);
//       }
//     } on DioException catch (e) {
//       return e.response ??
//           Response(
//             requestOptions: RequestOptions(path: endpoint),
//             statusCode: 500,
//             data: {'message': 'Something went wrong'},
//           );
//     }
//   }
// }

// class HttpException implements Exception {
//   final String message;
//   final int code;

//   HttpException(this.message, {required this.code});

//   @override
//   String toString() => 'HttpException: $message (Code: $code)';
// }
