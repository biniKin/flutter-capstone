import 'package:capstone_project/features/core/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthUseCases {
  final AuthRepository _authRepository;

  AuthUseCases(this._authRepository);

  Future<User?> signUp(String email, String password, String username) async {
    try {
      return await _authRepository.signUp(email, password, username);
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      return await _authRepository.login(email, password);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _authRepository.signOut();
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      return await _authRepository.getCurrentUser();
    } catch (e) {
      rethrow;
    }
  }
} 