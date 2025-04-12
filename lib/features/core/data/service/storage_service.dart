import 'package:capstone_project/features/core/data/models/cart_item_model.dart';
import 'package:capstone_project/features/core/data/models/cart_model.dart';
import 'package:capstone_project/features/core/data/models/order_model.dart';
import 'package:capstone_project/features/core/data/models/product_model.dart';
import 'package:capstone_project/features/core/data/models/user_model.dart';
import 'package:capstone_project/features/core/domain/entities/cart_item.dart';
import 'package:capstone_project/features/core/domain/entities/order_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StorageService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Save user data
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

  // Update user data
  Future<void> updateUserData(
    String uid,
    String name,
    String email,
    String phone,
    String address,
  ) async {
    try {
      await firestore.collection('users').doc(uid).set({
        'uid': uid,
        'email': email,
        'name': name,
        'phone': phone,
        'address': address,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      throw Exception("Failed to update user data: $e");
    }
  }

  // Add to cart
  Future<void> addToCart(String userId, CartItem cartItem) async {
    final cartItemJson = CartItemModel.fromEntity(cartItem).toJson();

    await firestore
        .collection('carts')
        .doc(userId)
        .collection('items')
        .doc(cartItem.product.id) // Using product ID as doc ID
        .set(cartItemJson);
  }

  // Remove from cart
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

  // Clear cart
  Future<void> clearCart(String userId) async {
    try {
      final cartItemsSnapshot = await firestore
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

  // Get cart
  Future<CartModel> getCart(String userId) async {
    try {
      final cartSnapshot = await firestore
          .collection('carts')
          .doc(userId)
          .collection('items')
          .get();

      final cartItems = cartSnapshot.docs.map((doc) {
        final data = doc.data();
        return CartItemModel(
          product: ProductModel.fromJson(data['product']),
          quantity: data['quantity'] ?? 1,
        );
      }).toList();

      return CartModel(
        userId: userId,
        items: cartItems,
      );
    } catch (e) {
      print('Error fetching cart: $e');
      // Return empty cart instead of throwing error
      return CartModel(userId: userId, items: []);
    }
  }

  // Update entire cart
  Future<void> updateCart(
    String userId,
    List<CartItem> updatedCartItems,
  ) async {
    try {
      final batch = firestore.batch();

      for (var cartItem in updatedCartItems) {
        final cartItemModel = CartItemModel.fromEntity(cartItem);
        batch.set(
          firestore
              .collection('carts')
              .doc(userId)
              .collection('items')
              .doc(cartItem.product.id),
          cartItemModel.toJson(),
        );
      }

      await batch.commit();
    } catch (e) {
      throw Exception('Error updating cart: $e');
    }
  }

  // Create order
  Future<void> createOrder(String userId, List<CartItem> cartItems) async {
    try {
      // Calculate total
      final total = cartItems.fold(0.0, (sum, item) => sum + (item.product.price * item.quantity));
      
      final orderModel = OrderModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: userId,
        products: cartItems.map((item) => ProductModel.fromEntity(item.product)).toList(),
        total: total,
        status: 'active',
      );

      final orderJson = orderModel.toJson();
      await firestore.collection('orders').add(orderJson);
    } catch (e) {
      throw Exception('Failed to create order: $e');
    }
  }

  // Fetch specific order by ID
  Future<List<OrderItem>> getOrderItems(String userId, String orderId) async {
    final doc = await firestore.collection('orders').doc(orderId).get();
    if (doc.exists) {
      final orderModel = OrderModel.fromJson(doc.data()!);
      return [orderModel.toEntity()];
    } else {
      return [];
    }
  }

  // Fetch all orders for user
  Future<List<OrderItem>> getUserOrders(String userId) async {
    final query = await firestore
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .get();

    return query.docs
        .map((doc) => OrderModel.fromJson(doc.data()).toEntity())
        .toList();
  }

  // Fetch user data
  Future<UserModel?> getUserData(String uid) async {
    try {
      final doc = await firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>, uid);
      }
    } catch (e) {
      throw Exception("error fetching user data: $e");
    }
    return null;
  }

  // Add to wishlist
  Future<void> addProductToWishlist(String userId, ProductModel product) async {
    try {
      await firestore
          .collection('wishlists')
          .doc(userId)
          .collection('items')
          .doc(product.id)
          .set(product.toJson());
    } catch (e) {
      throw Exception('Error adding product to wishlist: $e');
    }
  }

  // Remove from wishlist
  Future<void> removeProductFromWishlist(String userId, String productId) async {
    try {
      await firestore
          .collection('wishlists')
          .doc(userId)
          .collection('items')
          .doc(productId)
          .delete();
    } catch (e) {
      throw Exception('Error removing product from wishlist: $e');
    }
  }

  // Fetch wishlist
  Future<List<ProductModel>> getWishlistData(String userId) async {
    try {
      final wishlistSnapshot = await firestore
          .collection('wishlists')
          .doc(userId)
          .collection('items')
          .get();

      return wishlistSnapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Error fetching wishlist: $e');
    }
  }

  // Get notification settings
  Future<bool> getNotificationSettings(String userId) async {
    try {
      final doc = await firestore.collection('users').doc(userId).get();
      return doc.data()?['notificationsEnabled'] ?? true;
    } catch (e) {
      print('Error getting notification settings: $e');
      return true; // Default to enabled if there's an error
    }
  }

  // Update notification settings
  Future<void> updateNotificationSettings(String userId, bool enabled) async {
    try {
      await firestore.collection('users').doc(userId).set({
        'notificationsEnabled': enabled,
      }, SetOptions(merge: true));
    } catch (e) {
      throw Exception('Error updating notification settings: $e');
    }
  }
}
