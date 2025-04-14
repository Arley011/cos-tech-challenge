import 'package:cos_test/core/app_storage/app_storage.dart';
import 'package:cos_test/core/exceptions/auth/russian_terrorist_error.dart';
import 'package:cos_test/features/auth/data/services/local_auth_cache_service.dart';
import 'package:cos_test/features/auth/domain/models/app_user.dart';
import 'package:cos_test/features/auth/domain/repositories/auth_repository.dart';

/// Implementation of [AuthRepository] abstract class
class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl({required this.cacheService});

  /// Cache service for auth cache managing.
  final LocalAuthCacheService cacheService;

  /// Method to authenticate user with [email] and [password].
  /// If [rememberMe] option is set, stores the user in the local cache.
  @override
  Future<AppUser> login(
    String email,
    String password, {
    bool rememberMe = true,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    final isTerrorist = email.endsWith('.ru');
    if (isTerrorist) {
      throw RussianTerroristError();
    }

    final loggedUser = AppUser(
      email: email,
      password: password,
    );

    if (rememberMe) {
      await cacheService.saveUser(loggedUser);
    }

    return loggedUser;
  }

  /// Method to get the logged user from the local cache.
  @override
  Future<AppUser?> getLoggedUser() {
    return cacheService.getCachedUser();
  }

  /// Logs out the [user] by deleting the user from the local cache.
  @override
  Future<void> logout(AppUser user) async {
    await AppStorage.instance.deleteString(AppStorageKey.loggedUser);
  }
}
