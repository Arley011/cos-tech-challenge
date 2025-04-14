/// Custom exception class for authentication errors.
class AuthError implements Exception {
  /// A message describing the authentication error.
  final String message;

  const AuthError(this.message);

  @override
  String toString() {
    return 'AuthException: $message';
  }
}
