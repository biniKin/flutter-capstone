class User {
  final String uid;
  final String email;
  final String username;
  final String role;

  User({
    required this.uid,
    required this.email,
    required this.username,
    this.role = 'customer',
  });
}
