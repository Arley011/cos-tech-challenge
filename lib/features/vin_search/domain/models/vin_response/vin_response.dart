import 'package:cos_test/features/vin_search/data/models/vin_search_api_result.dart';
import 'package:cos_test/features/vin_search/domain/models/auction_data.dart';
import 'package:cos_test/features/vin_search/domain/models/similar_vehicle.dart';
import 'package:cos_test/features/vin_search/domain/models/vin_search_error/vin_search_error.dart';

part 'vin_search_error_response.dart';
part 'vin_search_similar_results.dart';
part 'vin_search_success.dart';

/// A sealed class representing the response from a VIN search API.
sealed class VinResponse {
  const VinResponse();

  factory VinResponse.fromVinSearchApiResult(VinSearchApiResult result) {
    if (result.error != null) {
      return VinSearchErrorResponse(
        result.error!,
      );
    } else if (result.similarVehicles != null) {
      return VinSearchSimilarResults(
        similarVehicles: result.similarVehicles!,
      );
    } else if (result.result != null) {
      return VinSearchSuccess(result.result!);
    }

    throw Exception('Invalid VinResponse: $result');
  }
}
