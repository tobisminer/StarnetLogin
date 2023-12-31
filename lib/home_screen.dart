import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String? token;

  const HomeScreen({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("STIS"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Card(
            child: Column(
              children: [
                const Text("Token:"),
                Text(token ?? "null"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
