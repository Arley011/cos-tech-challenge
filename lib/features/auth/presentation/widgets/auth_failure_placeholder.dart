import 'package:flutter/material.dart';

/// A simple placeholder widget for displaying authentication failure messages.
/// Provides an error message and a retry button.
class AuthFailurePlaceholder extends StatelessWidget {
  const AuthFailurePlaceholder({
    super.key,
    this.errorMessage,
    required this.onRetry,
  });

  /// Error message to be displayed.
  final String? errorMessage;

  /// Callback function to be called when the retry button is pressed.
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Authentication Error',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  errorMessage!,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                ),
              ),
            OutlinedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
