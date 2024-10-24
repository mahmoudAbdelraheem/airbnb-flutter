class UserModel {
  final String id;
  final String name;
  final String email;
  final List<String> favoriteIds;
  final String? image;
  final String? displayName;
  final String? address;
  final String? emergencyContact;
  final String? governmentId;
  final String? phoneNumber;
  final String? preferredName;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.favoriteIds,
    this.image,
    this.displayName,
    this.address,
    this.emergencyContact,
    this.governmentId,
    this.phoneNumber,
    this.preferredName,
  });

  // From JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      favoriteIds: List<String>.from(json['favoritesIds'] ?? []),
      image: json['image'],
      displayName: json['displayName'],
      address: json['address'],
      emergencyContact: json['emergencyContact'],
      governmentId: json['governmentId'],
      phoneNumber: json['phoneNumber'],
      preferredName: json['preferredName'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'favoriteIds': favoriteIds,
      'image': image,
      'displayName': displayName,
      'address': address,
      'emergencyContact': emergencyContact,
      'governmentId': governmentId,
      'phoneNumber': phoneNumber,
      'preferredName': preferredName,
    };
  }
}
