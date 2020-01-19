abstract class AuthService<T> {
  Future<String> signIn(String email, String password);

  Future<String> signUp(String email, String password);

  Future<T> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();
}
