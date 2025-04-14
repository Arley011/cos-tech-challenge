part of 'vin_search_error.dart';

/// A class representing an unknown error that occurs during VIN search.
final class VinSearchErrorUnknown extends VinSearchError {
  VinSearchErrorUnknown(super.error);

  @override
  String get title => 'Something went wrong';

  @override
  String get message => 'If problem persists, please contact support';
}