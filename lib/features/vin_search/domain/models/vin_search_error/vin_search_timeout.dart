part of 'vin_search_error.dart';

/// A class representing a timeout error that occurs during VIN search.
final class VinSearchTimeout extends VinSearchError {
  VinSearchTimeout(super.error);

  @override
  String get title => 'The request timed out.';

  @override
  String get message =>
      'Make sure you have a stable internet connection and try again.';
}
