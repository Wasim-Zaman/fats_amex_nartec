import 'package:dio/dio.dart';
import 'package:fats_amex_nartec/models/user/user.dart';

import '../core/services/http_service.dart';

class AuthRepository {
  final HttpService _httpService;

  AuthRepository({HttpService? httpService})
      : _httpService = httpService ?? HttpService();

  Future<User> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _httpService.request(
        '/v1/user/login',
        method: HttpMethod.post,
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final userData = response.data['data']['user'];
        // // Save tokens
        // await _httpService.storage.saveTokens(
        //   accessToken: userData['accessToken'],
        //   refreshToken: userData['refreshToken'],
        // );
        return User.fromJson(userData);
      }

      throw Exception(response.data['message'] ?? 'Login failed');
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Login failed');
    }
  }
}
