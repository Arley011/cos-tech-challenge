part of 'vin_response.dart';

/// A class representing an error response from the VIN search API.
final class VinSearchErrorResponse extends VinResponse {
  const VinSearchErrorResponse(this.error);

  final VinSearchApiError error;

  @override
  String toString() => '$runtimeType(error: $error)';
}
