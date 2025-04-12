import 'package:capstone_project/features/core/domain/entities/user.dart';

class UserModel {
  final String uid;
  final String email;
  final String name;
  final String? phone;
  final String? address;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    this.phone,
    this.address,
  });

  User toEntity() => User(uid: uid, username: name, email: email);

  //convert firestore doc to usermodel
  factory UserModel.fromMap(Map<String, dynamic> map, String uid) {
    return UserModel(
      uid: uid,
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'],
      address: map['address'],
    );
  }

  //
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'phone': phone,
      'address': address,
    };
  }
}
