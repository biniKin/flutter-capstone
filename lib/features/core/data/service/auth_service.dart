import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<User?> signIn(String password, String email) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      throw Exception('');
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      throw Exception('');
    }
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
