import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String username;

  ProfileScreen({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Text(
          'Selamat datang, $username!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}