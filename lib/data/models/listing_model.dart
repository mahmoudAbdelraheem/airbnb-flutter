class ListingModel {
  final bool approved;
  final int bathroomCount;
  final String categoryId;
  final String createdAt;
  final String description;
  final String descriptionAr;
  final int guestCount;
  final String id;
  final List<String> imageSrc;
  final String location;
  final String locationAr;
  final List<String> mapLocation;
  final double price;
  final String region;
  final int roomCount;
  final String title;
  final String titleAr;
  final String userId;

  ListingModel({
    required this.approved,
    required this.bathroomCount,
    required this.categoryId,
    required this.createdAt,
    required this.description,
    required this.descriptionAr,
    required this.guestCount,
    required this.id,
    required this.imageSrc,
    required this.location,
    required this.locationAr,
    required this.mapLocation,
    required this.price,
    required this.region,
    required this.roomCount,
    required this.title,
    required this.titleAr,
    required this.userId,
  });

  // Convert from JSON
  factory ListingModel.fromJson(Map<String, dynamic> json) {
    return ListingModel(
      approved: json['approved'] ?? false, // Handling null with fallback
      bathroomCount: json['bathroomCount'] is int
          ? json['bathroomCount']
          : int.parse(json['bathroomCount'].toString()),
      categoryId: json['categoryId'] ?? '', // Add default values if necessary
      createdAt: json['createdAt'] ?? '',
      description: json['description'] ?? '',
      descriptionAr: json['descriptionAr'] ?? '',
      guestCount: json['guestCount'] is int
          ? json['guestCount']
          : int.parse(json['guestCount'].toString()),
      id: json['id'] ?? '',
      imageSrc:
          List<String>.from(json['imageSrc'] ?? []), // Handle missing lists
      location: json['location'] ?? '',
      locationAr: json['locationAr'] ?? '',
      mapLocation: json['mapLocation'] != null
          ? List<String>.from(json['mapLocation'].map((e) => e.toString()))
          : [],
      price: json['price'] is double
          ? json['price']
          : double.parse(json['price'].toString()),
      region: json['region'] ?? '',
      roomCount: json['roomCount'] is int
          ? json['roomCount']
          : int.parse(json['roomCount'].toString()),
      title: json['title'] ?? '',
      titleAr: json['titleAr'] ?? '',
      userId: json['userId'] ?? '',
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'approved': approved,
      'bathroomCount': bathroomCount,
      'categoryId': categoryId,
      'createdAt': createdAt,
      'description': description,
      'descriptionAr': descriptionAr,
      'guestCount': guestCount,
      'id': id,
      'imageSrc': imageSrc,
      'location': location,
      'locationAr': locationAr,
      'mapLocation': mapLocation,
      'price': price,
      'region': region,
      'roomCount': roomCount,
      'title': title,
      'titleAr': titleAr,
      'userId': userId,
    };
  }
}
