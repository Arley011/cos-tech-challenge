import 'package:cos_test/features/vin_search/domain/models/auction_data.dart';
import 'package:cos_test/features/vin_search/presentation/widgets/auction_info_container.dart';
import 'package:cos_test/features/vin_search/presentation/widgets/customer_feedback.dart';
import 'package:flutter/material.dart';

/// A view for displaying auction data and a customer feedback.
class AuctionView extends StatelessWidget {
  const AuctionView._({
    super.key,
    required this.auctionData,
  });

  static const String routeName = 'auction-view';

  static PageRoute<T> route<T>({
    required AuctionData auctionData,
  }) {
    return MaterialPageRoute<T>(
      builder: (_) => AuctionView._(
        auctionData: auctionData,
      ),
      settings: const RouteSettings(name: routeName),
    );
  }

  /// Auction data to be displayed.
  final AuctionData auctionData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auction Data'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuctionInfoContainer(label: 'Make', value: auctionData.make),
                AuctionInfoContainer(label: 'Model', value: auctionData.model),
                AuctionInfoContainer(
                  label: 'Price',
                  value: auctionData.price.toString(),
                ),
                AuctionInfoContainer(
                  label: 'UUID',
                  value: auctionData.auctionUuid,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomerFeedback(
              isPositive: auctionData.positiveCustomerFeedback,
              feedback: auctionData.feedback,
            ),
          ),
        ],
      ),
    );
  }
}
