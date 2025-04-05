import 'package:capstone_project/features/core/data/models/order_model.dart';
import 'package:capstone_project/features/core/data/service/storage_service.dart';

class OrderReop {
  StorageService storageService = StorageService();

  //
  Future<void> saveOrder(OrderModel order) async {
    return await storageService.saveOrder(order);
  }

  //
  Future<OrderModel?> getOrderFormFirestore(String id) async {
    return storageService.getOrderData(id);
  }
}
