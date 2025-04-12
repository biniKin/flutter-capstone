import 'package:flutter/material.dart';
import 'package:capstone_project/features/core/presentation/screens/checkout_page.dart';
import 'package:capstone_project/features/core/data/service/storage_service.dart';
import 'package:capstone_project/features/core/domain/entities/cart_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:capstone_project/features/core/data/models/cart_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/ic.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final StorageService _storageService = StorageService();
  List<CartItem> _cartItems = [];
  bool _isLoading = true;
  double _total = 0.0;

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final CartModel cart = await _storageService.getCart(user.uid);
        setState(() {
          _cartItems = cart.toEntityList();
          _calculateTotal();
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading cart items: $e');
      setState(() => _isLoading = false);
    }
  }

  void _calculateTotal() {
    _total = _cartItems.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
  }

  Future<void> _updateQuantity(CartItem item, int newQuantity) async {
    if (newQuantity < 1) return;

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final updatedItem = CartItem(
          product: item.product,
          quantity: newQuantity,
        );
        
        final updatedItems = _cartItems.map((cartItem) {
          if (cartItem.product.id == item.product.id) {
            return updatedItem;
          }
          return cartItem;
        }).toList();

        await _storageService.updateCart(user.uid, updatedItems);
        
        setState(() {
          _cartItems = updatedItems;
          _calculateTotal();
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating quantity: $e')),
      );
    }
  }

  Future<void> _removeItem(CartItem item) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await _storageService.removeFromCart(user.uid, item.product.id);
        setState(() {
          _cartItems.removeWhere((cartItem) => cartItem.product.id == item.product.id);
          _calculateTotal();
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Item removed from cart')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error removing item: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Iconify(Ic.round_arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: _cartItems.isEmpty
          ? Center(
              child: Text(
                'Your cart is empty',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: _cartItems.length,
                      itemBuilder: (context, index) {
                        final item = _cartItems[index];
                        return _buildCartItem(item);
                      },
                    ),
                  ),
                  if (_cartItems.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    _buildOrderSummary(),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckoutPage(
                              cartItems: _cartItems,
                              total: _total,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6055D8),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Check Out',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
    );
  }

  Widget _buildCartItem(CartItem item) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.product.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    item.product.category,
                    style: GoogleFonts.poppins(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${(item.product.price * item.quantity).toStringAsFixed(2)}',
                    style: GoogleFonts.poppins(
                      color: Color(0xFF6055D8),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Iconify(Bi.dash_circle, color: Color(0xFF6055D8)),
                    onPressed: () => _updateQuantity(item, item.quantity - 1),
                  ),
                  Text(
                    item.quantity.toString(),
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                    ),
                  ),
                  IconButton(
                    icon: Iconify(Bi.plus_circle, color: Color(0xFF6055D8)),
                    onPressed: () => _updateQuantity(item, item.quantity + 1),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Iconify(Mdi.delete_outline, color: Colors.red),
              onPressed: () => _removeItem(item),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    final subtotal = _total;
    final discount = subtotal * 0.01; // 1% discount
    final deliveryCharges = 2.0;
    final total = subtotal - discount + deliveryCharges;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Summary',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildSummaryRow('Items', _cartItems.length.toString()),
            _buildSummaryRow('Subtotal', '\$${subtotal.toStringAsFixed(2)}'),
            _buildSummaryRow('Discount', '\$${discount.toStringAsFixed(2)}'),
            _buildSummaryRow('Delivery Charges', '\$${deliveryCharges.toStringAsFixed(2)}'),
            const Divider(height: 32),
            _buildSummaryRow('Total', '\$${total.toStringAsFixed(2)}', isBold: true),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
