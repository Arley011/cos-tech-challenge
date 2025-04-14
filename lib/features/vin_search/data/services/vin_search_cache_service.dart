import 'dart:convert';
import 'dart:developer';

import 'package:cos_test/core/app_storage/app_storage.dart';
import 'package:cos_test/features/vin_search/domain/models/auction_data.dart';

/// Service class for VIN search results cache.
class VinSearchCacheService {
  /// Searches for a cached auction data by its [vin].
  /// Returns [AuctionData] object if found, otherwise null.
  Future<AuctionData?> getCachedAuctionData(String vin) async {
    try {
      final cachedDataJson = await AppStorage.instance
          .getString(AppStorageKey.cachedVinSearch, keySuffix: vin);

      if (cachedDataJson == null) {
        return null;
      }

      final rawCachedData = jsonDecode(cachedDataJson) as Map<String, dynamic>;
      return AuctionData.fromMap(rawCachedData);
    } catch (e, st) {
      log('Failed to get cached auction data: $e\n$st');
    }
    return null;
  }

  /// Caches the auction data for a given [vin].
  Future<void> cacheAuctionData(String vin, AuctionData auctionData) async {
    try {
      final encodedData = jsonEncode(auctionData.toMap());
      return await AppStorage.instance.setString(
        AppStorageKey.cachedVinSearch,
        encodedData,
        keySuffix: vin,
      );
    } catch (e, st) {
      log('Failed to cache auction data: $e\n$st');
    }
  }
}
