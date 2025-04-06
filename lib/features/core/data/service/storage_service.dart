import 'package:capstone_project/features/core/data/models/cart_model.dart';
import 'package:capstone_project/features/core/data/models/order_model.dart';
import 'package:capstone_project/features/core/data/models/product_model.dart';
import 'package:capstone_project/features/core/data/models/user_model.dart';
import 'package:capstone_project/features/core/domain/entities/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StorageService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> saveUserDataToFirestore(UserModel user) async {
    try {
      await firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'name': user.name,
      });
    } catch (e) {
      throw Exception("Failed to save user data.");
    }
  }

  //
  Future<void> saveOrder(OrderModel order) async {
    try {
      await firestore.collection('orders').doc(order.id).set({
        'title': order.title,
        'id': order.id,
        'price': order.price,
        'imageUrl': order.imageUrl,
        'category': order.category,
      });
    } catch (e) {
      throw Exception('error on saving orders: $e');
    }
  }

  //
  Future<void> saveCart(String userId, Product product, int quantity) async {
    try {
      final cartModel = CartModel(
        id: product.id,
        title: product.title,
        price: product.price,
        category: product.category,
        imageUrl: product.imageUrl,
        quantity: quantity,
      );

      await firestore
          .collection('carts')
          .doc(userId)
          .collection('items')
          .doc(product.id)
          .set(cartModel.toJson());
    } catch (e) {
      throw Exception('Error adding item to cart: $e');
    }
  }

  //
  Future<List<CartModel>> getallCartItems(String userid) async {
    try {
      // Fetch all cart items for the given user ID from Firestore
      final cartModelSnapshot =
          await firestore
              .collection('carts')
              .doc(userid)
              .collection('items')
              .get();

      return cartModelSnapshot.docs.map((doc) {
        return CartModel.fromFirebase(doc.data());
      }).toList();
    } catch (e) {
      throw Exception('Error fetching cart items: $e');
    }
  }

  Future<void> removeFromCart(String userId, String productId) async {
    try {
      await firestore
          .collection('carts')
          .doc(userId)
          .collection('items')
          .doc(productId)
          .delete();
    } catch (e) {
      throw Exception('Error removing item from cart: $e');
    }
  }

  Future<void> clearCart(String userId) async {
    try {
      final cartItemsSnapshot =
          await firestore
              .collection('carts')
              .doc(userId)
              .collection('items')
              .get();
      final batch = firestore.batch();
      for (var doc in cartItemsSnapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    } catch (e) {
      throw Exception('Error clearing cart: $e');
    }
  }

  //
  Future<OrderModel?> getOrderData(String orderId) async {
    try {
      DocumentSnapshot doc = await firestore.collection('orders').doc(orderId).get();
      if (doc.exists) {
        return OrderModel.fromFirebase(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      throw Exception('Error fetching order by ID: $e');
    }
    return null;
  }

  // Fetch all orders for a specific user
  Future<List<OrderModel>> getUserOrders(String userId) async {
    try {
      final ordersSnapshot = await firestore
          .collection('orders')
          .where('userId', isEqualTo: userId)  // Filter by userId
          .get();

      return ordersSnapshot.docs.map((doc) {
        return OrderModel.fromFirebase(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      throw Exception('Error fetching orders for user: $e');
    }
  }

  Future<UserModel?> getUserData(String uid) async {
    try {
      DocumentSnapshot doc = await firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>, uid);
      }
    } catch (e) {
      throw Exception("error fetching user data: $e");
    }
    return null;
  }
  ///////////
  Future<void> addProductToWishlist(String userId, ProductModel product) async {
    try {
      await firestore.collection('wishlists').doc(userId).collection('items').doc(product.id).set(product.toJson());
    } catch (e) {
      throw Exception('Error adding product to wishlist: $e');
    }
  }

  // Remove ProductModel from wishlist collection
  Future<void> removeProductFromWishlist(String userId, String productId) async {
    try {
      await firestore.collection('wishlists').doc(userId).collection('items').doc(productId).delete();
    } catch (e) {
      throw Exception('Error removing product from wishlist: $e');
    }
  }

  // Fetch Wishlist data for a user
  Future<List<ProductModel>> getWishlistData(String userId) async {
    try {
      final wishlistSnapshot = await firestore
          .collection('wishlists')
          .doc(userId)
          .collection('items')
          .get();

      return wishlistSnapshot.docs.map((doc) => ProductModel.fromJson(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Error fetching wishlist: $e');
    }
  }
}
