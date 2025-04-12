import 'package:flutter/material.dart';
import 'package:capstone_project/features/core/data/models/product_model.dart';
import 'package:capstone_project/features/core/data/service/storage_service.dart';
import 'package:capstone_project/features/core/domain/entities/cart_item.dart';
import 'package:capstone_project/features/core/presentation/screens/cart_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/ic.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel product;
  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final StorageService _storageService = StorageService();
  bool _isInWishlist = false;
  bool _isLoading = false;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _checkIfInWishlist();
  }

  Future<void> _checkIfInWishlist() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final wishlistItems = await _storageService.getWishlistData(user.uid);
        setState(() {
          _isInWishlist = wishlistItems.any((item) => item.id == widget.product.id);
        });
      }
    } catch (e) {
      print('Error checking wishlist status: $e');
    }
  }

  Future<void> _addToCart() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please sign in to add items to cart')),
      );
      return;
    }

    try {
      setState(() => _isLoading = true);
      
      final cartItem = CartItem(
        product: widget.product.toEntity(),
        quantity: _quantity,
      );
      
      await _storageService.addToCart(user.uid, cartItem);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Added to cart successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding to cart: $e')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _toggleWishlist() async {
    if (_isLoading) return;
    
    setState(() {
      _isLoading = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        if (_isInWishlist) {
          await _storageService.removeProductFromWishlist(user.uid, widget.product.id);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Removed from wishlist')),
          );
        } else {
          await _storageService.addProductToWishlist(user.uid, widget.product);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Added to wishlist')),
          );
        }
        
        setState(() {
          _isInWishlist = !_isInWishlist;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please sign in to add to wishlist')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Product Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 280,
              child: Image.network(widget.product.imageUrl, fit: BoxFit.contain),
            ),
          ),

          // Top buttons
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Iconify(Ic.round_arrow_back, color: Colors.black),
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const CartPage()),
                          );
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Iconify(Mdi.cart_outline, color: Colors.black),
                        ),
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                                ),
                              )
                            : IconButton(
                                icon: Iconify(
                                  _isInWishlist ? Bi.heart_fill : Bi.heart,
                                  color: _isInWishlist ? Colors.red : Colors.black,
                                ),
                                onPressed: _toggleWishlist,
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Bottom Section (Details)
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.product.title,
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          "\$${widget.product.price}",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6055D8),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Iconify(Bi.star_fill, color: Colors.amber, size: 20),
                        Text(
                          "${widget.product.rate}  ",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "(${widget.product.count.toInt()} Review)",
                          style: GoogleFonts.poppins(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    Text(
                      "Description",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.product.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Quantity Selector
                    Row(
                      children: [
                        Text(
                          "Quantity",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Iconify(Bi.dash, color: Color(0xFF6055D8)),
                                onPressed: () {
                                  if (_quantity > 1) {
                                    setState(() => _quantity--);
                                  }
                                },
                              ),
                              Text(
                                _quantity.toString(),
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: Iconify(Bi.plus, color: Color(0xFF6055D8)),
                                onPressed: () {
                                  setState(() => _quantity++);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Add to Cart Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _addToCart,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6055D8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text(
                                "Add to Cart",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
