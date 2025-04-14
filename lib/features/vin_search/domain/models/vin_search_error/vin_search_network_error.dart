part of 'vin_search_error.dart';

/// A class representing a network error that occurs during VIN search.
final class VinSearchNetworkError extends VinSearchError {
  VinSearchNetworkError(super.error);

  @override
  String get title => 'Network error occurred.';

  @override
  String get message => 'Please check your internet connection and try again.';
}