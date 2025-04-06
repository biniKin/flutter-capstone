import 'package:capstone_project/features/core/domain/entities/product.dart';
import 'package:capstone_project/features/core/domain/entities/wishlist.dart';
import 'package:capstone_project/features/core/data/models/product_model.dart';
import 'package:capstone_project/features/core/data/service/storage_service.dart';
import 'package:capstone_project/features/core/domain/repositories/wishlist_repository.dart';

class WishlistRepo implements WishlistRepository {
  final StorageService _storageService = StorageService();

  @override
  Future<Wishlist> getWishlist(String userId) async {
    try {
      // Fetch wishlist items from Firestore
      final wishlistSnapshot = await _storageService.getWishlistData(userId);

      // Convert to the Wishlist entity
      List<Product> products = wishlistSnapshot.map((productModel) => productModel.toEntity()).toList();

      return Wishlist(userId: userId, products: products);
    } catch (e) {
      throw Exception("Error fetching wishlist: $e");
    }
  }

  @override
  Future<void> addToWishlist(String userId, Product product) async {
    try {
      // Convert the Product entity to ProductModel for storage
      final productModel = ProductModel(
        id: product.id,
        title: product.title,
        price: product.price,
        description: product.description,
        category: product.category,
        imageUrl: product.imageUrl,
        rate: product.rate,
        count: product.count,
      );

      // Save product model to Firestore
      await _storageService.addProductToWishlist(userId, productModel);
    } catch (e) {
      throw Exception("Error adding product to wishlist: $e");
    }
  }

  @override
  Future<void> removeFromWishlist(String userId, String productId) async {
    try {
      // Remove product from Firestore using productId
      await _storageService.removeProductFromWishlist(userId, productId);
    } catch (e) {
      throw Exception("Error removing product from wishlist: $e");
    }
  }
}
