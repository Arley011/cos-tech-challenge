import 'package:cos_test/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:cos_test/features/auth/data/services/local_auth_cache_service.dart';
import 'package:cos_test/features/auth/presentation/blocs/auth/auth_cubit.dart';
import 'package:cos_test/features/auth/presentation/blocs/login/login_cubit.dart';
import 'package:cos_test/features/auth/presentation/widgets/login_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A view for user login with email and password.
/// Login logic is handled by [LoginCubit] that is created and provided
/// when view is added via [page] method.
/// In case of successful login, calls [AuthCubit] to authenticate the user.
/// Has an ability to remember the user for future logins.
class LoginView extends StatefulWidget {
  const LoginView._({super.key});

  static Widget page({Key? key}) {
    return BlocProvider<LoginCubit>(
      create: (_) => LoginCubit(
        AuthRepositoryImpl(
          cacheService: LocalAuthCacheService(),
        ),
      ),
      child: LoginView._(
        key: key,
      ),
    );
  }

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rememberMeController = ValueNotifier<bool>(true);
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: _handleLoginListener,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 48),
                  child: Text(
                    'Welcome to CarOnSale',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    final emailErrorMessage =
                        state is LoginValidationFailedState
                            ? state.emailError
                            : null;
                    final passwordErrorMessage =
                        state is LoginValidationFailedState
                            ? state.passwordError
                            : null;

                    return LoginFormWidget(
                      emailController: emailController,
                      passwordController: passwordController,
                      emailFocusNode: emailFocusNode,
                      passwordFocusNode: passwordFocusNode,
                      emailErrorMessage: emailErrorMessage,
                      passwordErrorMessage: passwordErrorMessage,
                      onEmailSubmitted: _handleEmailSubmitted,
                      onPasswordSubmitted: _handlePasswordSubmitted,
                    );
                  },
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: rememberMeController,
                  builder: (context, isSelected, _) {
                    return CheckboxListTile.adaptive(
                      title: const Text(
                        'Remember me',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      visualDensity: VisualDensity.compact,
                      value: isSelected,
                      onChanged: (val) =>
                          rememberMeController.value = val ?? false,
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      return SizedBox(
                        height: 36,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 100),
                          child: state is LoginLoadingState
                              ? const CircularProgressIndicator()
                              : OutlinedButton(
                                  onPressed: _handleLoginPressed,
                                  child: const Text('Login'),
                                ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleLoginListener(BuildContext context, LoginState state) {
    if (state is LoginFailureState) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.error),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    } else if (state is LoginSuccessState) {
      context.read<AuthCubit>().authenticate(state.appUser);
    }
  }

  void _handleEmailSubmitted(String email) {
    passwordFocusNode.requestFocus();
    context.read<LoginCubit>().validateEmail(email);
  }

  void _handlePasswordSubmitted(String password) {
    _handleLoginPressed();
  }

  void _handleLoginPressed() {
    context.read<LoginCubit>().login(
          emailController.text,
          passwordController.text,
          rememberMe: rememberMeController.value,
        );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    rememberMeController.dispose();

    super.dispose();
  }
}
