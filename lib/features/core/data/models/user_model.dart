import 'package:capstone_project/features/core/domain/entities/user.dart';

class UserModel {
  String uid;
  String name;
  String email;

  UserModel({required this.uid, required this.name, required this.email});

  User toEntity() => User(uid: uid, username: name, email: email);

  //convert firestore doc to usermodel
  factory UserModel.fromMap(Map<String, dynamic> data, String uid) {
    return UserModel(
      uid: uid,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
    );
  }

  //
  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email, 'uid': uid};
  }
}
