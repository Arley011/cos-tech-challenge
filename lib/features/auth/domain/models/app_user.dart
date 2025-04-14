import 'package:equatable/equatable.dart';

/// Modal for app user object.
class AppUser extends Equatable {
  const AppUser({
    required this.email,
    required this.password,
  });

  factory AppUser.fromMap(Map<String, dynamic> data) {
    return AppUser(
      email: data['email'] as String,
      password: data['password'] as String,
    );
  }

  /// App user email.
  final String email;

  /// App user password.
  final String password;

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}
