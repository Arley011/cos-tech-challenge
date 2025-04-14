import 'dart:convert';

import 'package:cos_test/core/cos_challenge.dart';
import 'package:cos_test/features/vin_search/data/models/vin_search_api_result.dart';
import 'package:http/http.dart' as http;

/// Service class for VIN search API.
class VinSearchApiService {
  const VinSearchApiService({
    required this.client,
    required this.user,
  });

  /// Http client for making requests.
  final http.Client client;

  /// User email for authentication header.
  final String? user;

  /// Sends a VIN search request to the API.
  /// Decodes the body and parses result.
  /// Returns [VinSearchApiResult] object.
  Future<VinSearchApiResult> searchByVin(String vin) async {
    final response = await client.get(
      Uri.parse('someUrl'),
      headers: _requestHeaders,
    );
    final decodedResult = jsonDecode(response.body);

    return VinSearchApiResult.fromMap(decodedResult, response.statusCode);
  }

  Map<String, String> get _requestHeaders => {
        if (user != null) CosChallenge.user: user!,
      };
}
