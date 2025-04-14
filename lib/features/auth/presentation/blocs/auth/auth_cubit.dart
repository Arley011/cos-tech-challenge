import 'dart:developer';

import 'package:cos_test/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:cos_test/features/auth/domain/models/app_user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

/// A Cubit for managing the authentication state.
/// Provides ability to authenticate previously logged user, authenticate a new
/// user, and logout.
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._repo) : super(AuthInitial());

  /// Authentication repository.
  final AuthRepositoryImpl _repo;

  /// Method that checks if the user is already logged in.
  /// If the user is logged in, emits [AuthSuccess] state with the user data.
  /// Otherwise, emits [AuthUnauthenticated] state.
  void init() async {
    log('Initializing AuthCubit');
    emit(AuthLoading());
    try {
      final savedUser = await _repo.getLoggedUser();
      if (savedUser != null) {
        log('Found saved user (${savedUser.email}). Logging in...');

        emit(AuthSuccess(savedUser));
        return;
      }
    } catch (e) {
      log('Error happened during saved user loading: $e');
    }

    emit(AuthUnauthenticated());
  }

  /// Method that authenticates a given [user].
  Future<void> authenticate(AppUser user) async {
    try {
      log('Authenticating user ${user.email}');
      emit(AuthLoading());

      await Future.delayed(const Duration(milliseconds: 300));

      emit(AuthSuccess(user));
      log('Successfully authenticated user ${user.email}');
    } catch (e, st) {
      log('Error happened during authentication: $e\n$st');
      emit(const AuthFailure('Something went wrong. Please try again later'));
    }
  }

  /// Logs out the user.
  Future<void> logout() async {
    final currentState = state;
    if (currentState is! AuthSuccess) {
      log('Already logged out!');
      return;
    }

    log('Logging out...');

    await _repo.logout(currentState.sessionUser);

    log('Successfully logged out');
    emit(AuthUnauthenticated());
  }
}
