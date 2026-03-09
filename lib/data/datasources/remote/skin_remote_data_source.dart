// import '../../models/skin_product_model.dart';

// /// Abstract class for remote data sources (API)
// abstract class SkinRemoteDataSource {
//   /// Fetch all products from API
//   Future<List<SkinProductModel>> getAllProducts();

//   /// Fetch product by id
//   Future<SkinProductModel> getProductById(String id);

//   /// Search products
//   Future<List<SkinProductModel>> searchProducts(String query);

//   /// Add new product
//   Future<SkinProductModel> addProduct(SkinProductModel product);

//   /// Update product
//   Future<SkinProductModel> updateProduct(SkinProductModel product);

//   /// Delete product
//   Future<void> deleteProduct(String id);
// }

// /// Implementation of Remote Data Source
// class SkinRemoteDataSourceImpl implements SkinRemoteDataSource {
//   // TODO: Inject HTTP client (e.g., Dio, http package)

//   @override
//   Future<List<SkinProductModel>> getAllProducts() async {
//     // TODO: Implement API call
//     throw UnimplementedError('Implement API call to get all products');
//   }

//   @override
//   Future<SkinProductModel> getProductById(String id) async {
//     // TODO: Implement API call
//     throw UnimplementedError('Implement API call to get product by id');
//   }

//   @override
//   Future<List<SkinProductModel>> searchProducts(String query) async {
//     // TODO: Implement API call
//     throw UnimplementedError('Implement API call to search products');
//   }

//   @override
//   Future<SkinProductModel> addProduct(SkinProductModel product) async {
//     // TODO: Implement API call
//     throw UnimplementedError('Implement API call to add product');
//   }

//   @override
//   Future<SkinProductModel> updateProduct(SkinProductModel product) async {
//     // TODO: Implement API call
//     throw UnimplementedError('Implement API call to update product');
//   }

//   @override
//   Future<void> deleteProduct(String id) async {
//     // TODO: Implement API call
//     throw UnimplementedError('Implement API call to delete product');
//   }
// }
