import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../repositories/auth_repository.dart';
import 'auth_state.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository());

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.watch(authRepositoryProvider));
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthNotifier(this._repository) : super(const AuthState.initial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AuthState.loading();

    try {
      final user = await _repository.login(
        email: email,
        password: password,
      );
      state = AuthState.success(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }
}
