class CategoryModel {
  final String description;
  final String icon;
  final String label;

  CategoryModel({
    required this.description,
    required this.icon,
    required this.label,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      description: json['description'],
      icon: json['icon'],
      label: json['label'],
    );
  }
}
