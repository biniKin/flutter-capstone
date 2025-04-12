import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getCurrentUser();
  Future<Either<Failure, User>> updateUserProfile({
    required String uid,
    String? username,
    String? phone,
    String? address,
  });
  Future<Either<Failure, void>> updateDisplayName(String displayName);
} 