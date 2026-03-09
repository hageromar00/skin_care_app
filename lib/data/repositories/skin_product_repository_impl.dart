// import 'package:dartz/dartz.dart';

// import '../../core/errors/failures.dart';
// import '../../domain/entities/skin_product.dart';
// import '../../domain/repositories/skin_product_repository.dart';
// import '../datasources/local/skin_local_data_source.dart';
// import '../datasources/remote/skin_remote_data_source.dart';

// /// Implementation of SkinProductRepository
// class SkinProductRepositoryImpl implements SkinProductRepository {
//   final SkinRemoteDataSource remoteDateSource;
//   final SkinLocalDataSource localDataSource;

//   const SkinProductRepositoryImpl({
//     required this.remoteDateSource,
//     required this.localDataSource,
//   });

//   @override
//   Future<Either<Failure, List<SkinProduct>>> getAllProducts() async {
//     try {
//       // Try to get from remote first
//       final remoteProducts = await remoteDateSource.getAllProducts();
//       // Cache the products locally
//       await localDataSource.cacheAllProducts(remoteProducts);
//       return Right(remoteProducts.map((model) => model.toEntity()).toList());
//     } catch (e) {
//       // If remote fails, try to get from local cache
//       try {
//         final cachedProducts = await localDataSource.getAllProducts();
//         return Right(cachedProducts.map((model) => model.toEntity()).toList());
//       } catch (e) {
//         return Left(ServerFailure('Failed to load products: $e'));
//       }
//     }
//   }

//   @override
//   Future<Either<Failure, SkinProduct>> getProductById(String id) async {
//     try {
//       final product = await remoteDateSource.getProductById(id);
//       return Right(product.toEntity());
//     } catch (e) {
//       try {
//         final cachedProduct = await localDataSource.getProductById(id);
//         return Right(cachedProduct.toEntity());
//       } catch (e) {
//         return Left(ServerFailure('Failed to load product: $e'));
//       }
//     }
//   }

//   @override
//   Future<Either<Failure, List<SkinProduct>>> searchProducts(
//     String query,
//   ) async {
//     try {
//       // Remote API search
//       final results = await remoteDateSource.searchProducts(query);
//       return Right(results.map((model) => model.toEntity()).toList());
//     } catch (e) {
//       return Left(ServerFailure('Search failed: $e'));
//     }
//   }

//   @override
//   Future<Either<Failure, SkinProduct>> addProduct(SkinProduct product) async {
//     try {
//       // Create model from entity
//       final productModel = _entityToModel(product);
//       final result = await remoteDateSource.addProduct(productModel);
//       return Right(result.toEntity());
//     } catch (e) {
//       return Left(ServerFailure('Failed to add product: $e'));
//     }
//   }

//   @override
//   Future<Either<Failure, SkinProduct>> updateProduct(
//     SkinProduct product,
//   ) async {
//     try {
//       final productModel = _entityToModel(product);
//       final result = await remoteDateSource.updateProduct(productModel);
//       return Right(result.toEntity());
//     } catch (e) {
//       return Left(ServerFailure('Failed to update product: $e'));
//     }
//   }

//   @override
//   Future<Either<Failure, void>> deleteProduct(String id) async {
//     try {
//       await remoteDateSource.deleteProduct(id);
//       return const Right(null);
//     } catch (e) {
//       return Left(ServerFailure('Failed to delete product: $e'));
//     }
//   }

//   // Helper method to convert Entity to Model
//   dynamic _entityToModel(SkinProduct product) {
//     // This would be implemented with proper type conversion
//     throw UnimplementedError();
//   }
// }
