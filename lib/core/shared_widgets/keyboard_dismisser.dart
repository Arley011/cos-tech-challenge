import 'package:flutter/material.dart';

/// Common widget for dismissing the keyboard focus when tapping outside of a
/// text field.
class KeyboardDismisser extends StatelessWidget {
  const KeyboardDismisser({
    super.key,
    required this.child,
  });

  /// Child widget to be displayed inside the keyboard dismisser.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (_) => _unfocus(),
      child: child,
    );
  }

  void _unfocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
