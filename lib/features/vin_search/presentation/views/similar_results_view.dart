import 'package:cos_test/features/vin_search/domain/models/similar_vehicle.dart';
import 'package:cos_test/features/vin_search/presentation/widgets/similar_result_list_tile.dart';
import 'package:flutter/material.dart';

/// A view that displays a list of similar vehicles. Used when exact match
/// is not found for the VIN search and server returned similar vehicles.
class SimilarResultsView extends StatelessWidget {
  const SimilarResultsView._({
    super.key,
    required this.similarVehicles,
  });

  static const String routeName = 'similar-results';

  static PageRoute<T> route<T>({
    required List<SimilarVehicle> similarVehicles,
  }) {
    return MaterialPageRoute<T>(
      builder: (_) => SimilarResultsView._(
        similarVehicles: similarVehicles,
      ),
      settings: const RouteSettings(name: routeName),
    );
  }

  /// List of [SimilarVehicle] to be displayed.
  final List<SimilarVehicle> similarVehicles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Similar Results'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: Text(
              "We didn't found the exact match for your VIN. Here are some similar vehicles:",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: similarVehicles.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final vehicle = similarVehicles[index];

                return SimilarResultListTile(vehicle);
              },
            ),
          ),
        ],
      ),
    );
  }
}
