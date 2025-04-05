import 'package:capstone_project/features/core/data/service/auth_service.dart';
import 'package:flutter/material.dart';

class SimpleAuthPage extends StatefulWidget {
  const SimpleAuthPage({super.key});

  @override
  State<SimpleAuthPage> createState() => _SimpleAuthPageState();
}

class _SimpleAuthPageState extends State<SimpleAuthPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  AuthService authService = AuthService();

  void signIn() async {
    await authService.signIn(
      _passwordController.text,
      _emailController.text.trim(),
      _nameController.text.trim(),
    );
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: signIn,
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
