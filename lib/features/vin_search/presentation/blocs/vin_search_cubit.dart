import 'dart:async';
import 'dart:developer';

import 'package:cos_test/core/cos_challenge.dart';
import 'package:cos_test/core/utils/regex_utils.dart';
import 'package:cos_test/features/vin_search/domain/models/auction_data.dart';
import 'package:cos_test/features/vin_search/domain/models/similar_vehicle.dart';
import 'package:cos_test/features/vin_search/domain/models/vin_response/vin_response.dart';
import 'package:cos_test/features/vin_search/domain/models/vin_search_error/vin_search_error.dart';
import 'package:cos_test/features/vin_search/domain/repositories/vin_search_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'vin_search_state.dart';

/// A Cubit for searching vehicles by VIN.
class VinSearchCubit extends Cubit<VinSearchState> {
  VinSearchCubit(this._repository) : super(VinSearchInitialState());

  /// Repository for VIN search.
  final VinSearchRepository _repository;

  /// Searches for a vehicle by its VIN and emits the appropriate state.
  Future<void> searchVin(String? vin) async {
    try {
      final validatedVin = _formatAndValidateVin(vin);
      emit(VinSearchLoadingState());
      log('Searching by VIN: $vin');

      final response = await _repository.searchVin(validatedVin);
      log('VIN search response: $response');

      switch (response) {
        case VinSearchErrorResponse():
          throw response.error;
        case VinSearchSimilarResults():
          emit(VinSearchSimilarResultsState(response.similarVehicles));
        case VinSearchSuccess():
          emit(VinSearchSuccessState(response.auctionData));
      }
    } catch (e, st) {
      log('Error occurred while searching VIN: $e\n$st');
      emit(VinSearchErrorState(VinSearchError.fromError(e)));
    }
  }

  /// Formats the VIN to uppercase and removes whitespace characters.
  /// Validates the VIN format and length. In case of invalid input,
  /// throws a [VinSearchInvalidInputError].
  String _formatAndValidateVin(String? vin) {
    final formattedVin = vin?.replaceAll(RegExp(r'\s'), '').toUpperCase();
    if (formattedVin == null || formattedVin.isEmpty) {
      throw const VinSearchInvalidInputError('VIN cannot be empty');
    }
    if (!RegexUtils.vinRegExp.hasMatch(formattedVin)) {
      throw const VinSearchInvalidInputError(
        'Invalid VIN format. Should not contain spaces or special characters or letters I, O, Q',
      );
    }
    if (formattedVin.length != CosChallenge.vinLength) {
      throw const VinSearchInvalidInputError(
        'VIN must be ${CosChallenge.vinLength} characters long',
      );
    }

    return formattedVin;
  }
}
