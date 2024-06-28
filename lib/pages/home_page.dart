import 'package:flutter/material.dart';
import 'package:flutter_app_chat/auth/auth_service.dart';
import 'package:flutter_app_chat/components/custom_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void logout() {
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Home page"),
        ),
        actions: [
          IconButton(onPressed: logout, icon: const Icon(Icons.logout))
        ],
      ),
      drawer: const CustomDrawer(),
    );
  }
}
