part of 'vin_response.dart';

/// A class representing a partially successful response with similar vehicles
final class VinSearchSimilarResults extends VinResponse {
  const VinSearchSimilarResults({required this.similarVehicles});

  final List<SimilarVehicle> similarVehicles;

  @override
  String toString() =>
      'VinSearchSimilarResults(similarVehicles: $similarVehicles)';
}
