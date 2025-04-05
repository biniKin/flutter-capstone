import 'package:capstone_project/features/core/data/service/auth_service.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  AuthService authService = AuthService();

  // auth repositories
  Future<User?> signIn(String name, String email, String password) async {
    return await authService.signIn(password, email, name);
  }

  Future<User?> logIn(String password, String email) async {
    return await authService.login(email, password);
  }

  Future<void> signOut() async {
    authService.signOut();
  }
}
