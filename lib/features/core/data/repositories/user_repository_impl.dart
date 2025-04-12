import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  UserRepositoryImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final currentUser = firebaseAuth.currentUser;
      if (currentUser == null) {
        return Left(AuthFailure('No user is currently signed in'));
      }

      final userDoc = await firestore.collection('users').doc(currentUser.uid).get();
      if (!userDoc.exists) {
        return Left(AuthFailure('User document not found'));
      }

      final userModel = UserModel.fromFirestore(userDoc);
      return Right(userModel);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> updateUserProfile({
    required String uid,
    String? username,
    String? phone,
    String? address,
  }) async {
    try {
      final userRef = firestore.collection('users').doc(uid);
      final updates = <String, dynamic>{};

      if (username != null) {
        updates['username'] = username;
        await firebaseAuth.currentUser?.updateDisplayName(username);
      }
      if (phone != null) updates['phone'] = phone;
      if (address != null) updates['address'] = address;

      await userRef.update(updates);
      
      final updatedDoc = await userRef.get();
      final updatedUser = UserModel.fromFirestore(updatedDoc);
      return Right(updatedUser);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateDisplayName(String displayName) async {
    try {
      final currentUser = firebaseAuth.currentUser;
      if (currentUser == null) {
        return Left(AuthFailure('No user is currently signed in'));
      }

      await currentUser.updateDisplayName(displayName);
      await firestore.collection('users').doc(currentUser.uid).update({
        'username': displayName,
      });

      return const Right(null);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }
} 