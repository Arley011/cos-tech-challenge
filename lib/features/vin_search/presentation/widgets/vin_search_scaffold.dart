import 'package:flutter/material.dart';

/// A widget that provides a basic scaffold for the VIN search screen.
class VinSearchScaffold extends StatelessWidget {
  const VinSearchScaffold({
    super.key,
    required this.child,
    required this.onLogout,
  });

  /// The child widget to be displayed inside the scaffold.
  final Widget child;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            actions: [
              TextButton(
                onPressed: onLogout,
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: child,
          ),
        ),
      ),
    );
  }
}
