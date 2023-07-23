import 'package:flutter/material.dart';
import 'package:starnet_login/utils.dart';
import 'package:starnet_login/home_screen.dart';
import 'package:starnet_login/constants/strings.dart';

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
      showErrorToUser(e, context);
    }
  }

  void hideSnackBar() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
        title: const Text(appName),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(loginScreenTitle,
                style: Theme.of(context).textTheme.displaySmall),
            const SizedBox(height: 10.0),
            SizedBox(
                height: 70.0,
                child: TextField(
                  controller: _userController,
                  onChanged: (value) {
                    setState(() {
                      hideSnackBar();
                    });
                  },
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 25.0, horizontal: 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      prefixIcon:
                          const Icon(Icons.supervised_user_circle_sharp),
                      labelText: loginUserName),
                )),
            const SizedBox(height: 10.0),
            SizedBox(
                height: 70.0,
                child: TextField(
                  controller: _passwordController,
                  obscureText: hidePassword,
                  enableSuggestions: false,
                  autocorrect: false,
                  onChanged: (value) {
                    setState(() {
                      hideSnackBar();
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 25.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    prefixIcon: const Icon(Icons.fingerprint),
                    suffix: Transform.translate(
                        offset: const Offset(0.0, 5.0),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                            icon: Icon(hidePassword
                                ? Icons.remove_red_eye
                                : Icons.remove_red_eye_outlined))),
                    labelText: loginPassword,
                  ),
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: ElevatedButton(
                  onPressed: () => _login(),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  child: const Text(loginButton)),
            )
          ]),
        ),
      ),
    );
  }
}
