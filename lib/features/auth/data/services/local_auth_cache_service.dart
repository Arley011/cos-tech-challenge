import 'dart:convert';

import 'package:cos_test/core/app_storage/app_storage.dart';
import 'package:cos_test/features/auth/domain/models/app_user.dart';

/// Service for caching authentication data locally.
/// Uses [AppStorage] singleton to store and retrieve user data.
class LocalAuthCacheService {
  /// Checks local cache for a saved user.
  /// Returns an [AppUser] object if found, otherwise null.
  Future<AppUser?> getCachedUser() async {
    final userJson = await AppStorage.instance.getString(
      AppStorageKey.loggedUser,
    );

    if (userJson == null) {
      return null;
    }

    return AppUser.fromMap(jsonDecode(userJson) as Map<String, dynamic>);
  }

  /// Saves the provided [user] to local cache.
  Future<void> saveUser(AppUser user) async {
    await AppStorage.instance.setString(
      AppStorageKey.loggedUser,
      jsonEncode(user.toMap()),
    );
  }
}
