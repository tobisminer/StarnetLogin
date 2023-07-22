import 'package:flutter/material.dart';
import 'package:starnet_login/utils.dart';
import 'package:starnet_login/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: LoginScreen());
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool hidePassword = true;
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    final String username = _userController.text;
    final String password = _passwordController.text;

    try {
      final String? token = await getToken(username, password);
      setState(() {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => HomeScreen(token: token)));
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
            content: Text(e.toString()),
          )
      );
    }

  }

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
        title: const Text("STIS Přihlášení"),
        backgroundColor: Colors.red,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _userController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.supervised_user_circle_sharp),
                hintText: "Uživatel"),
          ),
          TextField(
            controller: _passwordController,
            obscureText: hidePassword,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.password),
              suffix: IconButton(
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                  icon: Icon(hidePassword
                      ? Icons.remove_red_eye
                      : Icons.remove_red_eye_outlined)),
              hintText: "Heslo",
            ),
          ),
          ElevatedButton(
              onPressed: () => _login(), child: const Text("Přihlásit se"))
        ],
      ),
    );
  }
}
