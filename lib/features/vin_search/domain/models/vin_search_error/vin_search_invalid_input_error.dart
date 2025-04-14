part of 'vin_search_error.dart';

/// A class representing an invalid input error that occurs during VIN search.
class VinSearchInvalidInputError extends VinSearchError {
  const VinSearchInvalidInputError(this.message);

  @override
  final String message;

  @override
  String get title => 'Invalid VIN input';
}
