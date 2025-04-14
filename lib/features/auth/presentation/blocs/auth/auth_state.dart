part of 'auth_cubit.dart';

/// A sealed class representing the different states of the authentication
sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// A state representing the initial state of the authentication process.
final class AuthInitial extends AuthState {}

/// A state representing the unauthenticated state of the user.
final class AuthUnauthenticated extends AuthState {}

/// A state representing the authenticated state of the user.
final class AuthLoading extends AuthState {}

/// A state representing the authenticated state of the user.
/// Contains the [AppUser] object.
final class AuthSuccess extends AuthState {
  final AppUser sessionUser;

  const AuthSuccess(this.sessionUser);

  @override
  List<Object?> get props => [sessionUser];
}

/// A state representing the authentication failure.
/// Contains an error message.
final class AuthFailure extends AuthState {
  final String error;

  const AuthFailure(this.error);

  @override
  List<Object?> get props => [error];
}
