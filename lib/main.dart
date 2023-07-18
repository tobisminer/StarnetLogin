import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyForm()
    );
  }
}

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  bool hidePassword = true;
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Starnet login"),
        backgroundColor: Colors.red,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _userController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.supervised_user_circle_sharp),
                hintText: "Uživatel"
            ),

          ),
          TextField(
            controller: _passwordController,
            obscureText: hidePassword,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.password),
              suffix: IconButton(onPressed: (){
                setState(() {
                  hidePassword = !hidePassword;
                });
              }, icon: Icon(hidePassword ? Icons.remove_red_eye : Icons.remove_red_eye_outlined)
              ),
              hintText: "Heslo",
            ),
          )
        ],
      ),
    );
  }
}

