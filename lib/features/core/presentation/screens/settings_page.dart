import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:capstone_project/features/core/data/service/storage_service.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final StorageService _storageService = StorageService();
  String _userName = '';
  String _userEmail = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userData = await _storageService.getUserData(user.uid);
        if (mounted) {
          setState(() {
            _userName = userData?.name ?? user.displayName ?? 'User';
            _userEmail = user.email ?? '';
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      print('Error loading user data: $e');
      if (mounted) {
        setState(() {
          _userName = 'User';
          _userEmail = '';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Settings",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Account",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      leading: CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: NetworkImage('https://s3-alpha-sig.figma.com/img/5784/2d50/c4b613fc7a5e890b4a3f4d0de8921c8a?Expires=1745193600&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=RVc8x60qMTe7lhOb7IGeOY5PvIT29a2DtaweCadgXShjgopPVO7iXJUFixqOCZtoRCozqzI~otjQoV-a~KtrsGEgAmMwxc11F7TzrIkGvXYPuSrnr9UEaMD3RkNZLPH6vHzPfQI4aGMUweWNjZr2y5xS-k8rSEDnCrLSO9w7KOdrKKP85zIqmNfDOr1W9ezfOq2hpcVWXu~8hX9FsblAST7PYRbdVu8WkIGQrUy~Sd7pHBlFbA67uZAJMcPp9035G2ozXQmOiQyxK6lNprDBVw4xSkUVVb0evhpzJQeTKxD4t9J8t~dHcVR-ydrTaTvxPKlfib8IudXwNZyiJCjXCw__'),
                      ),
                      title: Text(
                        _userName,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        _userEmail,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 30),
                    Text(
                      "Setting",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      leading: const Icon(Icons.notifications),
                      title: Text(
                        "Notifications",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      leading: const Icon(Icons.language),
                      title: Text(
                        "Language",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "English",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      leading: const Icon(Icons.privacy_tip),
                      title: Text(
                        "Privacy",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      leading: const Icon(Icons.headset_mic),
                      title: Text(
                        "Help Center",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      leading: const Icon(Icons.info),
                      title: Text(
                        "About us",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
} 