import 'package:cos_test/features/vin_search/domain/models/vin_response/vin_response.dart';

/// Abstract class for VIN search repository.
abstract class VinSearchRepository {
  /// Searches for a vehicle by its [vin].
  /// Returns [VinResponse] object.
  Future<VinResponse> searchVin(String vin);
}
