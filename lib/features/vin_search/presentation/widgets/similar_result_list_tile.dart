import 'package:cos_test/features/vin_search/domain/models/similar_vehicle.dart';
import 'package:flutter/material.dart';

/// A widget that displays a list tile for a similar vehicle.
class SimilarResultListTile extends StatelessWidget {
  const SimilarResultListTile(
    this.vehicle, {
    super.key,
  });

  /// [SimilarVehicle] to be displayed.
  final SimilarVehicle vehicle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${vehicle.make} ${vehicle.model}'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Container Name:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(vehicle.containerName),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text('ID: ${vehicle.externalId}'),
          ),
        ],
      ),
    );
  }
}
