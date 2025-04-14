import 'dart:developer';

import 'package:cos_test/core/validators/auth_validators.dart';
import 'package:cos_test/features/auth/domain/models/app_user.dart';
import 'package:cos_test/features/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

/// A Cubit for managing the login state.
/// Provides methods to login, validate email and password,
/// and handle validation errors.
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._repo) : super(LoginInitialState());

  /// Repository for authentication.
  final AuthRepository _repo;

  /// Logs in the user with the provided email and password.
  /// Validates the email and password before attempting to log in.
  /// If validation fails, emits [LoginValidationFailedState].
  /// If login is successful, emits [LoginSuccessState].
  /// If an error occurs, emits [LoginFailureState].
  Future<void> login(
    String email,
    String password, {
    bool rememberMe = true,
  }) async {
    try {
      emit(LoginLoadingState());
      log('Validating email and password');
      final emailValidationError = AuthValidators.emailValidator(email);
      final passwordValidationError =
          AuthValidators.passwordValidator(password);

      if (emailValidationError != null || passwordValidationError != null) {
        log(
          'Validation failed. '
          'Email error: $emailValidationError, '
          'Password error: $passwordValidationError',
        );

        emit(
          LoginValidationFailedState(
            emailError: emailValidationError,
            passwordError: passwordValidationError,
          ),
        );
        return;
      }
      log(
        'Validation successful. '
        'Logging in with email: $email. '
        'Remember me: $rememberMe',
      );

      final user = await _repo.login(email, password, rememberMe: rememberMe);
      emit(LoginSuccessState(user));
    } catch (e, st) {
      log('Error occurred during login: $e\n$st');
      emit(LoginFailureState(e.toString()));
    }
  }

  /// Validates the provided email and emits a [LoginValidationFailedState]
  /// if the validation fails.
  void validateEmail(String email) {
    final currentState = state;
    final error = AuthValidators.emailValidator(email);
    if (currentState is LoginValidationFailedState) {
      emit(currentState.copyWithEmailError(emailError: error));
    } else {
      if (error == null) {
        emit(LoginInitialState());
      } else {
        emit(LoginValidationFailedState(emailError: error));
      }
    }
  }

  /// Validates the provided password and emits a [LoginValidationFailedState]
  /// if the validation fails.
  void validatePassword(String password) {
    final currentState = state;
    final error = AuthValidators.passwordValidator(password);
    if (currentState is LoginValidationFailedState) {
      emit(currentState.copyWithPasswordError(passwordError: error));
    } else {
      if (error == null) {
        emit(LoginInitialState());
      } else {
        emit(LoginValidationFailedState(passwordError: error));
      }
    }
  }
}
