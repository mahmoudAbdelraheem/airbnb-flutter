class ListingModel {
  final bool approved;
  final int bathroomCount;
  final String category;
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
    required this.category,
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
      approved: json['approved'],
      bathroomCount: json['bathroomCount'],
      category: json['category'],
      createdAt: json['createdAt'],
      description: json['description'],
      descriptionAr: json['descriptionAr'],
      guestCount: json['guestCount'],
      id: json['id'],
      imageSrc: List<String>.from(json['imageSrc']),
      location: json['location'],
      locationAr: json['locationAr'],
      mapLocation: List<String>.from(json['mapLocation']),
      price: json['price'].toDouble(),
      region: json['region'],
      roomCount: json['roomCount'],
      title: json['title'],
      titleAr: json['titleAr'],
      userId: json['userId'],
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'approved': approved,
      'bathroomCount': bathroomCount,
      'category': category,
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
