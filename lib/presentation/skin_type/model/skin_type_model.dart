class SkinTypeModel {
  final String title;
  final String description;
  final String image;
  bool isSelected;

  SkinTypeModel({
    required this.title,
    required this.description,
    required this.image,
    this.isSelected = false,
  });
}