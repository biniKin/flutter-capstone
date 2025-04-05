import 'package:capstone_project/features/core/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> signUp(String email, String password, String username);
  Future<User> login(String email, String password);
  Future<void> logout();
  Future<User?> getCurrentUser();
}
