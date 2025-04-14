part of 'vin_response.dart';

/// A class representing a successful VIN search response.
final class VinSearchSuccess extends VinResponse {
  const VinSearchSuccess(this.auctionData);

  final AuctionData auctionData;

  @override
  String toString() => 'VinSearchSuccess(auctionData: $auctionData)';
}
