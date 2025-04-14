import 'package:flutter/material.dart';

/// A widget that provides a login form with email and password fields.
/// Shows error messages if provided - [emailErrorMessage], [passwordErrorMessage].
class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    required this.onEmailSubmitted,
    required this.onPasswordSubmitted,
    this.emailErrorMessage,
    this.passwordErrorMessage,
  });

  /// Text editing controller for the email field.
  final TextEditingController emailController;

  /// Text editing controller for the password field.
  final TextEditingController passwordController;

  /// Focus node for the email field.
  final FocusNode emailFocusNode;

  /// Focus node for the password field.
  final FocusNode passwordFocusNode;

  /// Optional error message for the email field.
  final String? emailErrorMessage;

  /// Optional error message for the password field.
  final String? passwordErrorMessage;

  /// Callback for when the email field is submitted.
  final ValueChanged<String> onEmailSubmitted;

  /// Callback for when the password field is submitted.
  final ValueChanged<String> onPasswordSubmitted;

  static const _errorTextStyle = TextStyle(
    color: Colors.red,
    fontWeight: FontWeight.w600,
    fontSize: 12,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: emailController,
          focusNode: emailFocusNode,
          decoration: InputDecoration(
            hintText: 'Email',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onSubmitted: onEmailSubmitted,
          keyboardType: TextInputType.emailAddress,
        ),
        if (emailErrorMessage != null)
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              emailErrorMessage!,
              style: _errorTextStyle,
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: TextField(
            controller: passwordController,
            focusNode: passwordFocusNode,
            decoration: InputDecoration(
              hintText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onSubmitted: onPasswordSubmitted,
            keyboardType: TextInputType.visiblePassword,
          ),
        ),
        if (passwordErrorMessage != null)
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              passwordErrorMessage!,
              style: _errorTextStyle,
            ),
          ),
      ],
    );
  }
}
