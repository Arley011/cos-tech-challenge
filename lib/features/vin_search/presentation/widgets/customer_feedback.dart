import 'package:flutter/material.dart';

/// A widget that displays customer feedback with an icon and text.
class CustomerFeedback extends StatelessWidget {
  const CustomerFeedback({
    super.key,
    required this.isPositive,
    this.feedback,
  });

  /// Whether the feedback is positive or negative.
  final bool isPositive;

  /// Optional feedback text.
  final String? feedback;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: feedbackColor.withOpacity(0.1),
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            feedbackIcon,
            color: feedbackColor,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              feedbackTitle,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: feedbackColor,
              ),
            ),
          ),
          if (feedback != null)
            Container(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                feedback!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
        ],
      ),
    );
  }

  String get feedbackTitle =>
      isPositive ? 'Positive Feedback' : 'Negative Feedback';

  IconData get feedbackIcon => isPositive ? Icons.thumb_up : Icons.thumb_down;

  Color get feedbackColor => isPositive ? Colors.green : Colors.red;
}
