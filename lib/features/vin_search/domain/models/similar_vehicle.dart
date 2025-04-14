import 'package:equatable/equatable.dart';

/// A model class representing a similar vehicle.
class SimilarVehicle extends Equatable {
  const SimilarVehicle({
    required this.make,
    required this.model,
    required this.containerName,
    required this.similarity,
    required this.externalId,
  });

  factory SimilarVehicle.fromMap(Map<String, dynamic> map) {
    return SimilarVehicle(
      make: map['make'] as String,
      model: map['model'] as String,
      containerName: map['containerName'] as String,
      similarity: map['similarity'] as int,
      externalId: map['externalId'] as String,
    );
  }

  /// Vehicle make.
  final String make;

  /// Vehicle model.
  final String model;

  /// Container name.
  final String containerName;

  /// Similarity score (0-99). The higher the score, the more similar the
  /// vehicle is.
  final int similarity;

  /// External ID of the vehicle.
  final String externalId;

  Map<String, dynamic> toMap() {
    return {
      'make': make,
      'model': model,
      'containerName': containerName,
      'similarity': similarity,
      'externalId': externalId,
    };
  }

  @override
  List<Object?> get props => [
        make,
        model,
        containerName,
        similarity,
        externalId,
      ];

  @override
  String toString() {
    return 'SimilarVehicle: ${toMap().toString()}';
  }
}
