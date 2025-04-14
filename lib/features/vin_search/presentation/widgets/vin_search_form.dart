import 'package:cos_test/core/cos_challenge.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A widget that represents the VIN search form.
/// It contains a label, a text field for entering the VIN, and a button to
/// trigger and initiate the search.
class VinSearchForm extends StatelessWidget {
  const VinSearchForm({
    super.key,
    required this.isLoading,
    required this.vinController,
    required this.onSearchPressed,
  });

  /// Whether the form is currently loading.
  final bool isLoading;

  /// The controller for the VIN text field.
  final TextEditingController vinController;

  /// Callback function to be called when the search button is pressed.
  final VoidCallback onSearchPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'VIN Search',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32, bottom: 24),
          child: TextField(
            enabled: !isLoading,
            controller: vinController,
            inputFormatters: [
              LengthLimitingTextInputFormatter(
                CosChallenge.vinLength,
              ),
            ],
            decoration: InputDecoration(
              hintText: 'Enter VIN',
              errorMaxLines: 3,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 36,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 100),
            child: isLoading
                ? const CircularProgressIndicator()
                : OutlinedButton(
                    onPressed: onSearchPressed,
                    child: const Text('Search'),
                  ),
          ),
        ),
      ],
    );
  }
}
