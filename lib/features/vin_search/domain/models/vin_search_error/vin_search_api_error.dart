part of 'vin_search_error.dart';

/// A class representing an API error that occurs during VIN search.
class VinSearchApiError extends VinSearchError {
  VinSearchApiError(
    super.error, {
    this.msgKey,
    this.params,
    required this.message,
  });

  factory VinSearchApiError.fromMap(Map<String, dynamic> data) {
    return VinSearchApiError(
      data,
      msgKey: data['msgKey'] as String?,
      params: data['params'] as Map<String, dynamic>?,
      message: data['message'] as String,
    );
  }

  final String? msgKey;

  final Map<String, dynamic>? params;

  @override
  final String message;

  @override
  String get title => 'Oops! Server returned an error';
}
