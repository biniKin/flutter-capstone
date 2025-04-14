import 'package:flutter/material.dart';
import 'package:capstone_project/features/core/domain/repositories/auth_repository.dart';
import 'package:capstone_project/features/core/domain/use_cases/auth_use_cases.dart';
import 'package:capstone_project/features/core/data/repositories/auth_repo.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:iconify_flutter/icons/ic.dart';

class SignupPage extends StatefulWidget {
  final void Function()? onTap;
  const SignupPage({super.key, required this.onTap});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _auth = AuthUseCases(AuthRepositoryImpl());
  final emailController = TextEditingController();
  final userController = TextEditingController();
  final pwController = TextEditingController();
  bool _isLoading = false;
  final ValueNotifier<bool> _isObscure = ValueNotifier<bool>(true);
  
  Future<void> signUp() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);
    
    try {
      final user = await _auth.signUp(
        emailController.text.trim(),
        pwController.text,
        userController.text.trim(),
      );
      
      if (mounted) {
        if (user != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Successfully signed up!')),
          );
          // Navigate to home page or next screen
          widget.onTap?.call();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to sign up')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    userController.dispose();
    pwController.dispose();
    _isObscure.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      backgroundColor: const Color(0xFF6055D8),
      body: Stack(
        children: [
          Positioned(
            top: screenHeight * 0.15, // 15% from top
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(70)),
              ),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05,
                          vertical: screenHeight * 0.03,
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Sign up",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.09, // Responsive font size
                                color: const Color(0xFF6055D8),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.03),

                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "UserName",
                                style: GoogleFonts.poppins(
                                  fontSize: screenWidth * 0.035,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            // Username TextField
                            TextFormField(
                              controller: userController,
                              decoration: InputDecoration(
                                hintText: "User name",
                                prefixIcon: Iconify(Bi.person),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your username';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Email",
                                style: GoogleFonts.poppins(
                                  fontSize: screenWidth * 0.035,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            // Email TextField
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: "example@example.com",
                                prefixIcon: Iconify(Ic.email),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!value.contains('@')) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Password",
                                style: GoogleFonts.poppins(
                                  fontSize: screenWidth * 0.035,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            // Password TextField
                            ValueListenableBuilder<bool>(
                              valueListenable: _isObscure,
                              builder: (context, isObscure, _) {
                                return TextFormField(
                                  controller: pwController,
                                  obscureText: isObscure,
                                  decoration: InputDecoration(
                                    hintText: ". . . . . . .",
                                    prefixIcon: Iconify(Ic.lock),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        _isObscure.value = !isObscure;
                                      },
                                      icon: Iconify(
                                        isObscure
                                            ? Ic.outline_visibility
                                            : Ic.outline_visibility_off,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    if (value.length < 6) {
                                      return 'Password must be at least 6 characters';
                                    }
                                    return null;
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(
                          bottom: screenHeight * 0.05,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              width: screenWidth * 0.7, // 70% of screen width
                              height: screenHeight * 0.07, // 7% of screen height
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                    const Color(0xFF6055D8),
                                  ),
                                ),
                                onPressed: _isLoading ? null : signUp,
                                child: _isLoading
                                    ? const CircularProgressIndicator(color: Colors.white)
                                    : Text(
                                        "Sign Up",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w800,
                                          fontSize: screenWidth * 0.05,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account? ",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: screenWidth * 0.035,
                                    color: Colors.grey,
                                  ),
                                ),
                                TextButton(
                                  onPressed: widget.onTap,
                                  child: Text(
                                    "Login",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.035,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.02),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
