import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StorageService {
  saveUserDataToFirestore(User user) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('users').doc(user.uid).set({
      'username': user.displayName ?? '',
      'email': user.email,
      'profilePic': user.photoURL,
    });
  }
}
