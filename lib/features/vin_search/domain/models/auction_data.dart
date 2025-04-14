import 'package:equatable/equatable.dart';

/// A model class representing auction data.
class AuctionData extends Equatable {
  const AuctionData({
    required this.id,
    this.feedback,
    this.valuatedAt,
    this.requestedAt,
    required this.createdAt,
    this.updatedAt,
    required this.make,
    required this.model,
    required this.externalId,
    required this.sellerUser,
    required this.price,
    required this.positiveCustomerFeedback,
    required this.auctionUuid,
    this.inspectorRequestedAt,
    required this.origin,
    required this.estimationRequestId,
  });

  factory AuctionData.fromMap(Map<String, dynamic> data) {
    return AuctionData(
      id: data['id'] as int,
      feedback: data['feedback'] as String?,
      valuatedAt: data['valuatedAt'] != null
          ? DateTime.parse(data['valuatedAt'] as String)
          : null,
      requestedAt: data['requestedAt'] != null
          ? DateTime.parse(data['requestedAt'] as String)
          : null,
      createdAt: DateTime.parse(data['createdAt'] as String),
      updatedAt: data['updatedAt'] != null
          ? DateTime.parse(data['updatedAt'] as String)
          : null,
      make: data['make'] as String,
      model: data['model'] as String,
      externalId: data['externalId'] as String,
      sellerUser: data['_fk_sellerUser'] as String,
      price: data['price'] as int,
      positiveCustomerFeedback: data['positiveCustomerFeedback'] as bool,
      auctionUuid: data['_fk_uuid_auction'] as String,
      inspectorRequestedAt: data['inspectorRequestedAt'] != null
          ? DateTime.parse(data['inspectorRequestedAt'] as String)
          : null,
      origin: data['origin'] as String,
      estimationRequestId: data['estimationRequestId'] as String,
    );
  }

  /// Auction ID.
  final int id;

  /// Optional feedback from the auction.
  final String? feedback;

  /// Date when the vehicle was valuated.
  final DateTime? valuatedAt;

  /// Date when the auction was requested.
  final DateTime? requestedAt;

  /// Date when the auction was created.
  final DateTime createdAt;

  /// Optional date when the auction was updated.
  final DateTime? updatedAt;

  /// Vehicle make.
  final String make;

  /// Vehicle model.
  final String model;

  /// External ID of the vehicle.
  final String externalId;

  /// Seller user ID.
  final String sellerUser;

  /// Price of the vehicle.
  final int price;

  /// Whether the customer feedback is positive.
  final bool positiveCustomerFeedback;

  /// Auction UUID.
  final String auctionUuid;

  /// Optional date when the inspector requested the auction.
  final DateTime? inspectorRequestedAt;

  /// Origin of the auction.
  final String origin;

  /// Estimation request ID.
  final String estimationRequestId;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'feedback': feedback,
      'valuatedAt': valuatedAt?.toIso8601String(),
      'requestedAt': requestedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'make': make,
      'model': model,
      'externalId': externalId,
      '_fk_sellerUser': sellerUser,
      'price': price,
      'positiveCustomerFeedback': positiveCustomerFeedback,
      '_fk_uuid_auction': auctionUuid,
      'inspectorRequestedAt': inspectorRequestedAt?.toIso8601String(),
      'origin': origin,
      'estimationRequestId': estimationRequestId,
    };
  }

  @override
  List<Object?> get props => [
        id,
        feedback,
        valuatedAt,
        requestedAt,
        createdAt,
        updatedAt,
        make,
        model,
        externalId,
        sellerUser,
        price,
        positiveCustomerFeedback,
        auctionUuid,
        inspectorRequestedAt,
        origin,
        estimationRequestId,
      ];

  @override
  String toString() {
    return 'AuctionData: ${toMap().toString()}';
  }
}
