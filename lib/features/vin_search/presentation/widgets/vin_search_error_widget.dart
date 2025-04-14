import 'package:cos_test/features/vin_search/domain/models/vin_search_error/vin_search_error.dart';
import 'package:flutter/material.dart';

/// A widget that displays a [VinSearchError] on the screen.
/// Provides an icon, title, and message based on the error type.
class VinSearchErrorWidget extends StatelessWidget {
  const VinSearchErrorWidget({
    super.key,
    required this.error,
  });

  /// VIN search error to be displayed.
  final VinSearchError error;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 32),
          child: Icon(
            iconByErrorType,
            color: errorColor,
            size: 48,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            error.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: errorColor,
            ),
          ),
        ),
        Text(
          error.message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  IconData get iconByErrorType {
    switch (error) {
      case VinSearchApiError():
        return Icons.error_rounded;
      case VinSearchNetworkError():
        return Icons.signal_wifi_off_rounded;
      case VinSearchTimeout():
        return Icons.access_time_rounded;
      case VinSearchErrorUnknown():
        return Icons.error_outline_rounded;
      case VinSearchInvalidInputError():
        return Icons.warning_amber_rounded;
    }
  }

  Color get errorColor {
    switch (error) {
      case VinSearchApiError():
      case VinSearchErrorUnknown():
        return Colors.red;
      case VinSearchNetworkError():
      case VinSearchTimeout():
      case VinSearchInvalidInputError():
        return Colors.orange;
    }
  }
}
