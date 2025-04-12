class User {
  final String uid;
  final String username;
  final String email;
  final String? phone;
  final String? address;

  User({
    required this.uid,
    required this.username,
    required this.email,
    this.phone,
    this.address,
  });
}
