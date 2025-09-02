import 'package:fats_amex_nartec/models/user/user.dart';

import '../core/network/network_client.dart';

class AuthRepository {
  final NetworkClient _networkClient;

  AuthRepository({NetworkClient? networkClient})
      : _networkClient = networkClient ?? NetworkClient.instance;

  Future<User> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _networkClient.post(
        '/v1/user/login',
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.isSuccess && response.data != null) {
        final userData = response.data['data']['user'];
        // // Save tokens
        // await _networkClient.storage.saveTokens(
        //   accessToken: userData['accessToken'],
        //   refreshToken: userData['refreshToken'],
        // );
        return User.fromJson(userData);
      }

      throw Exception(response.errorMessage.isNotEmpty
          ? response.errorMessage
          : 'Login failed');
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }
}
