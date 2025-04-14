part of 'vin_search_cubit.dart';

/// A sealed class representing the different states of the VIN search feature.
@immutable
sealed class VinSearchState extends Equatable {
  const VinSearchState();

  @override
  List<Object?> get props => [];
}

/// Initial state of the VIN search feature.
final class VinSearchInitialState extends VinSearchState {}

/// State when the VIN search is in progress.
final class VinSearchLoadingState extends VinSearchState {}

/// State when the VIN search is successful. Contains [AuctionData] object.
final class VinSearchSuccessState extends VinSearchState {
  const VinSearchSuccessState(this.auctionData);

  final AuctionData auctionData;

  @override
  List<Object?> get props => [
        auctionData,
      ];
}

/// State when the VIN search returns similar vehicles. Contains a list of
/// [SimilarVehicle].
final class VinSearchSimilarResultsState extends VinSearchState {
  const VinSearchSimilarResultsState(this.similarVehicles);

  final List<SimilarVehicle> similarVehicles;

  @override
  List<Object?> get props => [
        similarVehicles,
      ];
}

/// State when the VIN search fails. Contains a [VinSearchError] object.
final class VinSearchErrorState extends VinSearchState {
  const VinSearchErrorState(this.error);

  final VinSearchError error;

  @override
  List<Object?> get props => [
        error,
      ];
}
