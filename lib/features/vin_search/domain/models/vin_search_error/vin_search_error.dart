import 'dart:async';
import 'dart:io';

part 'vin_search_api_error.dart';
part 'vin_search_invalid_input_error.dart';
part 'vin_search_network_error.dart';
part 'vin_search_timeout.dart';
part 'vin_search_unknown_error.dart';

/// A base class representing an error that occurs during VIN search.
sealed class VinSearchError implements Exception {
  const VinSearchError([this.error]);

  factory VinSearchError.fromError(Object error) {
    if (error is TimeoutException) {
      return VinSearchTimeout(error);
    } else if (error is SocketException) {
      return VinSearchNetworkError(error);
    } else if (error is VinSearchInvalidInputError) {
      return error;
    } else if (error is VinSearchApiError) {
      return error;
    } else {
      return VinSearchErrorUnknown(error);
    }
  }

  /// The original error object.
  final Object? error;

  /// The title of the error.
  String get title;

  /// The message of the error with possible solution.
  String get message;

  @override
  String toString() {
    return '$runtimeType: ${error ?? title}';
  }
}
