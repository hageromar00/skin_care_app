/// Skin Product Entity - Independent of frameworks
class SkinProduct {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String imageUrl;
  final double rating;
  final int reviews;
  final bool inStock;

  const SkinProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.rating,
    required this.reviews,
    required this.inStock,
  });

  // CopyWith method for immutability
  SkinProduct copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? category,
    String? imageUrl,
    double? rating,
    int? reviews,
    bool? inStock,
  }) {
    return SkinProduct(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      reviews: reviews ?? this.reviews,
      inStock: inStock ?? this.inStock,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SkinProduct &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'SkinProduct(id: $id, name: $name, price: $price)';
}
