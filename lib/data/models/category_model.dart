class CategoryModel {
  final String id;
  final String description;
  final String icon;
  final String label;
  final String image;

  CategoryModel({
    required this.id,
    required this.description,
    required this.icon,
    required this.label,
    required this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      description: json['description'],
      icon: json['icon'],
      label: json['label'],
      image: json['image'],
    );
  }
}
