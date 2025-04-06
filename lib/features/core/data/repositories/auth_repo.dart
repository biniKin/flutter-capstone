import 'package:capstone_project/features/core/data/service/auth_service.dart';
import 'package:capstone_project/features/core/domain/repositories/auth_repository.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo implements AuthRepository {
  AuthService authService = AuthService();

  @override
  // auth repositories
  Future<User?> signUp(String name, String email, String password) async {
    return await authService.signUp(password, email, name);
  }

  @override
  Future<User?> login(String password, String email) async {
    return await authService.login(email, password);
  }

  @override
  Future<void> signOut() async {
    authService.signOut();
  }

  @override
  Future<User?> getCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }
}
