import 'package:cos_test/features/auth/domain/models/app_user.dart';

/// Abstract class for authentication repository.
abstract class AuthRepository {
  /// Logs in the user with the provided [email] and [password].
  /// Optionally, the [rememberMe] flag can be set to true to remember the user.
  /// Returns an [AppUser] object if login is successful.
  Future<AppUser> login(
    String email,
    String password, {
    bool rememberMe = true,
  });

  /// Retrieves the logged-in user from the cache.
  Future<AppUser?> getLoggedUser();

  /// Logs out the user.
  Future<void> logout(AppUser user);
}
