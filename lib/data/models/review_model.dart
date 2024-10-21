class ReviewModel {
  final String content;
  final String createdAt;
  final String hostId;
  final String listingId;
  final double rate;
  final String reviewerId;
  final String reviewerName;
  final String reviewerImage;

  ReviewModel({
    required this.content,
    required this.createdAt,
    required this.hostId,
    required this.listingId,
    required this.rate,
    required this.reviewerId,
    required this.reviewerName,
    required this.reviewerImage,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      content: json['content'] ?? '',
      createdAt: json['createdAt'] ?? '',
      hostId: json['hostId'] ?? '',
      listingId: json['listingId'] ?? '',
      rate: json['rate'] is int
          ? (json['rate'] as int).toDouble()
          : json['rate'] is String
              ? double.tryParse(json['rate']) ?? 0.0
              : json['rate'] ?? 0.0,
      reviewerId: json['reviwerId'] ?? '',
      reviewerName: json['reviwerName'] ?? '',
      reviewerImage: json['reviwerImage'] ?? '',
    );
  }

  Map<String, dynamic> toJson(ReviewModel review) {
    return {
      'content': review.content,
      'createdAt': review.createdAt,
      'hostId': review.hostId,
      'listingId': review.listingId,
      'rate': review.rate,
      'reviwerId': review.reviewerId,
      'reviwerName': review.reviewerName,
      'reviwerImage': review.reviewerImage,
    };
  }
}
