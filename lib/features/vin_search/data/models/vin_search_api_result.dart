import 'package:cos_test/features/vin_search/domain/models/auction_data.dart';
import 'package:cos_test/features/vin_search/domain/models/similar_vehicle.dart';
import 'package:cos_test/features/vin_search/domain/models/vin_search_error/vin_search_error.dart';

/// A DTO class representing the result of a VIN search API call.
class VinSearchApiResult {
  const VinSearchApiResult._({
    this.result,
    this.similarVehicles,
    this.error,
    required this.statusCode,
  });

  /// Auction data if the request was successful.
  final AuctionData? result;

  /// List of similar vehicles if the request was partially successful (300).
  final List<SimilarVehicle>? similarVehicles;

  /// Error information if the response is an error.
  final VinSearchApiError? error;

  /// HTTP status code of the response.
  final int statusCode;

  /// Factory method to resolve the response based on the status code and
  /// data format.
  factory VinSearchApiResult.fromMap(
    dynamic data,
    int statusCode,
  ) {
    if (statusCode == 200 && data is Map) {
      return VinSearchApiResult._(
        result: AuctionData.fromMap(data.cast<String, dynamic>()),
        statusCode: statusCode,
      );
    } else if (statusCode == 300 && data is List) {
      final similarVehicles = data
          .cast<Map<String, dynamic>>()
          .map((e) => SimilarVehicle.fromMap(e))
          .toList();

      return VinSearchApiResult._(
        similarVehicles: similarVehicles,
        statusCode: statusCode,
      );
    }

    if (data is Map) {
      return VinSearchApiResult._(
        error: VinSearchApiError.fromMap(data.cast<String, dynamic>()),
        statusCode: statusCode,
      );
    }

    throw FormatException('Invalid response format: ${data.toString()}');
  }
}
