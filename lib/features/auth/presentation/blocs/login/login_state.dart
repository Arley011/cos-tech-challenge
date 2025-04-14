part of 'login_cubit.dart';

/// A sealed class representing the different states of the login feature.
@immutable
sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

/// Initial state of the login feature.
final class LoginInitialState extends LoginState {}

/// State when the login is in progress.
final class LoginLoadingState extends LoginState {}

/// State when the login is successful. Contains [AppUser] object.
final class LoginSuccessState extends LoginState {
  const LoginSuccessState(this.appUser);

  final AppUser appUser;

  @override
  List<Object?> get props => [appUser];
}

/// State when the login validation fails. Contains optional error messages
/// for email and password.
final class LoginValidationFailedState extends LoginState {
  const LoginValidationFailedState({
    this.emailError,
    this.passwordError,
  });

  final String? emailError;
  final String? passwordError;

  LoginValidationFailedState copyWithEmailError({
    String? emailError,
  }) {
    return LoginValidationFailedState(
      emailError: emailError,
      passwordError: passwordError,
    );
  }

  LoginValidationFailedState copyWithPasswordError({
    String? passwordError,
  }) {
    return LoginValidationFailedState(
      emailError: emailError,
      passwordError: passwordError,
    );
  }

  @override
  List<Object?> get props => [
        emailError,
        passwordError,
      ];
}

/// State when the login fails. Contains an error message.
final class LoginFailureState extends LoginState {
  const LoginFailureState(
    this.error,
  );

  final String error;

  @override
  List<Object?> get props => [
        error,
      ];
}
