class AuthUseCases {
  final AuthRepository repository;

  AuthUseCases(this.repository);

  Future<User> signUp(String email, String password, String username) {
    return repository.signUp(email, password, username);
  }

  Future<User> login(String email, String password) {
    return repository.login(email, password);
  }

  Future<void> logout() {
    return repository.logout();
  }

  Future<User?> getCurrentUser() {
    return repository.getCurrentUser();
  }
}
