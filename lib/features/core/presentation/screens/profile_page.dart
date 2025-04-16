import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:capstone_project/features/core/presentation/screens/login_page.dart';
import 'package:capstone_project/features/core/presentation/screens/wishlist_page.dart';
import 'package:capstone_project/features/core/presentation/screens/edit_profile_page.dart';
import 'package:capstone_project/features/core/presentation/screens/orders_page.dart';
import 'package:capstone_project/features/core/presentation/screens/settings_page.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _userName = '';
  String _userEmail = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _userName = user.displayName ?? 'User';
        _userEmail = user.email ?? '';
      });
    }
  }

  void _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginPage(onTap: () {
        Navigator.pop(context);
      })),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Profile",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Profile Header
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[200],
                backgroundImage: NetworkImage('https://s3-alpha-sig.figma.com/img/5784/2d50/c4b613fc7a5e890b4a3f4d0de8921c8a?Expires=1745193600&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=RVc8x60qMTe7lhOb7IGeOY5PvIT29a2DtaweCadgXShjgopPVO7iXJUFixqOCZtoRCozqzI~otjQoV-a~KtrsGEgAmMwxc11F7TzrIkGvXYPuSrnr9UEaMD3RkNZLPH6vHzPfQI4aGMUweWNjZr2y5xS-k8rSEDnCrLSO9w7KOdrKKP85zIqmNfDOr1W9ezfOq2hpcVWXu~8hX9FsblAST7PYRbdVu8WkIGQrUy~Sd7pHBlFbA67uZAJMcPp9035G2ozXQmOiQyxK6lNprDBVw4xSkUVVb0evhpzJQeTKxD4t9J8t~dHcVR-ydrTaTvxPKlfib8IudXwNZyiJCjXCw__'),
              ),
              const SizedBox(height: 20),
              Text(
                _userName,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _userEmail,
                style: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 30),

              // Profile Options
              _buildProfileOption(
                icon: Icons.person_outline,
                title: "Edit Profile",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfilePage(),
                    ),
                  ).then((value) {
                    // Refresh user data when returning from edit profile
                    if (value == true) {
                      _loadUserData();
                    }
                  });
                },
              ),
              _buildProfileOption(
                icon: Icons.shopping_bag_outlined,
                title: "My Orders",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrdersPage(),
                    ),
                  );
                },
              ),
              _buildProfileOption(
                icon: Icons.favorite_border,
                title: "Wishlist",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WishlistPage(),
                    ),
                  );
                },
              ),
              _buildProfileOption(
                icon: Icons.location_on_outlined,
                title: "Shipping Address",
                onTap: () {
                  // TODO: Navigate to addresses
                },
              ),
              _buildProfileOption(
                icon: Icons.payment,
                title: "Payment Methods",
                onTap: () {
                  // TODO: Navigate to payment methods
                },
              ),
              _buildProfileOption(
                icon: Icons.settings_outlined,
                title: "Settings",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ),
                  );
                },
              ),
              _buildProfileOption(
                icon: Icons.help_outline,
                title: "Help & Support",
                onTap: () {
                  // TODO: Navigate to help
                },
              ),
              const SizedBox(height: 20),
              
              // Sign Out Button
              ElevatedButton(
                onPressed: () => _signOut(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[50],
                  foregroundColor: Colors.red,
                  elevation: 0,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Sign Out",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.black),
              const SizedBox(width: 16),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
