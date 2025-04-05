import 'package:capstone_project/features/core/data/models/cart_model.dart';
import 'package:capstone_project/features/core/data/models/order_model.dart';
import 'package:capstone_project/features/core/data/models/user_model.dart';
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
  Future<void> saveCart(CartModel cart) async {
    try {
      await firestore.collection('orders').doc(cart.id).set({
        'title': cart.title,
        'id': cart.id,
        'price': cart.price,
        'imageUrl': cart.imageUrl,
        'category': cart.category,
      });
    } catch (e) {
      throw Exception('error on saving orders: $e');
    }
  }

  //
  Future<CartModel?> getCartData(String id) async {
    try {
      DocumentSnapshot doc = await firestore.collection('orders').doc(id).get();
      if (doc.exists) {
        return CartModel.fromFirebase(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      throw Exception("error on getting orders: $e");
    }
    return null;
  }

  //
  Future<OrderModel?> getOrderData(String id) async {
    try {
      DocumentSnapshot doc = await firestore.collection('orders').doc(id).get();
      if (doc.exists) {
        return OrderModel.fromFirebase(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      throw Exception("error on getting orders: $e");
    }
    return null;
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
}
