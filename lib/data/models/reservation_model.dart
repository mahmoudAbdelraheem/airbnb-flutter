import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationModel {
  final String id;
  final String authorId;
  final String listingId;
  final String userId;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime createdAt;
  final double totalPrice;

  ReservationModel({
    required this.id,
    required this.authorId,
    required this.listingId,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.totalPrice,
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      id: json['id'] ?? '', // Default to empty string if 'id' is null
      authorId: json['authorId'] ?? '', // Default to empty string
      listingId: json['listingId'] ?? '',
      userId: json['userId'] ?? '',
      startDate: (json['startDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      endDate: (json['endDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0.0,
    );
  }

  // Convert an instance to a Firestore-compatible map
  Map<String, dynamic> toJson() {
    return {
      'authorId': authorId,
      'listingId': listingId,
      'userId': userId,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'createdAt': Timestamp.fromDate(createdAt),
      'totalPrice': totalPrice,
    };
  }
}
