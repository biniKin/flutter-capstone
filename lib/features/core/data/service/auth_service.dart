import 'package:capstone_project/features/core/data/models/user_model.dart';
import 'package:capstone_project/features/core/data/service/storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final StorageService _storageService = StorageService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUp(String password, String email, String name) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;
      if (user != null) {
        final userModel = UserModel(uid: user.uid, name: name, email: email);
        await _storageService.saveUserDataToFirestore(userModel);
        return user;
      } else {
        throw Exception('');
      }
    } catch (e) {
      throw Exception('Sign Up error: $e');
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      if (user != null) {
        // Fetch user data using StorageService
        await _storageService.getUserData(user.uid);
        return user;
      }
    } catch (e) {
      throw Exception('Login error: $e');
    }
    return null;
  }

  void signOut() async {
    await _auth.signOut();
  }
}
