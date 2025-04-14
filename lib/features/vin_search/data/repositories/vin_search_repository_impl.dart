import 'dart:developer';

import 'package:cos_test/features/vin_search/data/services/vin_search_api_service.dart';
import 'package:cos_test/features/vin_search/data/services/vin_search_cache_service.dart';
import 'package:cos_test/features/vin_search/domain/models/vin_response/vin_response.dart';
import 'package:cos_test/features/vin_search/domain/repositories/vin_search_repository.dart';

/// Repository implementation for VIN search.
class VinSearchRepositoryImpl extends VinSearchRepository {
  VinSearchRepositoryImpl({
    required this.apiService,
    required this.cacheService,
  });

  /// API service for VIN search.
  final VinSearchApiService apiService;

  /// Cache service for VIN search.
  final VinSearchCacheService cacheService;

  /// Searches for a vehicle by its [vin].
  /// If search succeeds, caches the result.
  /// If search fails, tries to return cached data.
  /// Returns [VinResponse] object.
  @override
  Future<VinResponse> searchVin(String vin) async {
    try {
      final apiResponse = await apiService.searchByVin(vin);

      final response = VinResponse.fromVinSearchApiResult(apiResponse);

      if (response is VinSearchSuccess) {
        await cacheService.cacheAuctionData(vin, response.auctionData);
      } else if (response is VinSearchErrorResponse) {
        throw response;
      } else if (response is VinSearchSimilarResults) {
        response.similarVehicles.sort((a, b) {
          return b.similarity.compareTo(a.similarity);
        });
      }

      return response;
    } catch (e) {
      final cachedData = await cacheService.getCachedAuctionData(vin);
      if (cachedData != null) {
        log('Using cached data on error response');
        return VinSearchSuccess(cachedData);
      }

      if (e is VinSearchErrorResponse) {
        return e;
      }

      rethrow;
    }
  }
}
