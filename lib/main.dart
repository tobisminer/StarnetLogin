import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:starnet_login/TokenBodyReq.dart';


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
  final String domain = "https://stis.starnet.cz/";

  void _login() async {
    final String username = _userController.text;
    final String password = _passwordController.text;
    final String token = await getToken(username, password);

  }
  Future<String> getToken(String username, String password) async{
    TokenBody body = TokenBody(apiLoginForm: ApiLoginForm(username: username, password: password, attr: Attr(androidOsVersion: "9.1", appTechnikVersion: "1.23", imei: "1246543365434")));
    var jsonBody = jsonEncode(body.toJson());
    Uri? url = Uri.tryParse("${domain}api-token/create");

    http.Request request = http.Request("post", url!);
    request.headers.clear();
    request.headers.addAll({"content-type":"application/json; charset=utf-8"});
    request.body = jsonBody;
    var letsGo = await request.send();
    print(request);
    print(request.body);
    print(letsGo.statusCode);



      /* {
      if (response.statusCode == 200) {
        print(response.body);
        return response.body;
      } else {
        print(response.statusCode);
        print(response.body);
        return "";
      }
    }).catchError((error) {
      print(error);
      return "";
    });*/


    return "";
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
        title: const Text("Starnet login"),
        backgroundColor: Colors.red,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
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
          ),
          ElevatedButton(
              onPressed: () => _login(),
              child: const Text("Přihlásit se")
          )
        ],
      ),
    );
  }
}

