import 'package:capstone_project/features/core/data/service/api_service.dart';
import 'package:capstone_project/features/core/data/service/storage_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final StorageService storageService = StorageService();
final ApiService apiService = ApiService();

final String title = '';
final String id = '';

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("home")));
  }
}
