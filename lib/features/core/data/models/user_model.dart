class UserModel {
  int id;
  String username;
  String email;
  String? profilePic;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    this.profilePic,
  });
}
