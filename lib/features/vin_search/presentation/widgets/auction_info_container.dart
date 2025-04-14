import 'package:flutter/material.dart';

/// A widget that displays auction information with a label and value.
class AuctionInfoContainer extends StatelessWidget {
  const AuctionInfoContainer({
    super.key,
    required this.label,
    required this.value,
  });

  /// Info container label.
  final String label;

  /// Info container text value.
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
