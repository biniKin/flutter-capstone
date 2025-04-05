import 'package:capstone_project/features/core/data/models/cart_model.dart';
import 'package:capstone_project/features/core/data/service/storage_service.dart';

class CartRepo {
  StorageService storageService = StorageService();

  //
  Future<void> saveCartToFirestore(CartModel cart) async {
    return await storageService.saveCart(cart);
  }

  //
  Future<CartModel?> getCartFromFirestore(String id) async {
    return await storageService.getCartData(id);
  }

}
