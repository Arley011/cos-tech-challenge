import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'app_storage_keys.dart';

/// A singleton class for managing secure storage in the app.
class AppStorage {
  const AppStorage._();

  static AppStorage? _instance;

  static AppStorage get instance {
    _instance ??= const AppStorage._();
    return _instance!;
  }

  final _storage = const FlutterSecureStorage();

  /// Reads a string value from secure storage by the given [key].
  /// Optionally, a [keySuffix] can be provided to use a unique key.
  Future<String?> getString(
    AppStorageKey key, {
    String? keySuffix,
  }) {
    return _storage.read(key: _resolveKey(key, keySuffix: keySuffix));
  }

  /// Writes a string value to secure storage with the given [key].
  /// Optionally, a [keySuffix] can be provided to use a unique key.
  Future<void> setString(
    AppStorageKey key,
    String value, {
    String? keySuffix,
  }) {
    return _storage.write(
        key: _resolveKey(key, keySuffix: keySuffix), value: value);
  }

  /// Deletes a string value from secure storage by the given [key].
  /// Optionally, a [keySuffix] can be provided to use a unique key.
  Future<void> deleteString(AppStorageKey key, {String? keySuffix}) {
    return _storage.delete(key: _resolveKey(key, keySuffix: keySuffix));
  }

  /// Resolves the storage key by combining the [key] name with an optional
  /// [keySuffix].
  String _resolveKey(
    AppStorageKey key, {
    String? keySuffix,
  }) {
    if (keySuffix != null) {
      return '${key.name}_$keySuffix';
    }
    return key.name;
  }

  Future<void> deleteAll() {
    return _storage.deleteAll();
  }
}
