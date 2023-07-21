import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String? token;
  const HomeScreen({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("STIS"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Center(
        child: Text(token!),
      ),
    );
  }
}
