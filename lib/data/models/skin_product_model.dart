import '../../domain/entities/skin_product.dart';

/// Model for SkinProduct with JSON serialization
class SkinProductModel extends SkinProduct {
  const SkinProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.category,
    required super.imageUrl,
    required super.rating,
    required super.reviews,
    required super.inStock,
  });

  /// Factory constructor from JSON
  factory SkinProductModel.fromJson(Map<String, dynamic> json) {
    return SkinProductModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      category: json['category'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviews: json['reviews'] as int? ?? 0,
      inStock: json['inStock'] as bool? ?? true,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'imageUrl': imageUrl,
      'rating': rating,
      'reviews': reviews,
      'inStock': inStock,
    };
  }

  /// Convert Model to Entity
  SkinProduct toEntity() {
    return SkinProduct(
      id: id,
      name: name,
      description: description,
      price: price,
      category: category,
      imageUrl: imageUrl,
      rating: rating,
      reviews: reviews,
      inStock: inStock,
    );
  }
}
