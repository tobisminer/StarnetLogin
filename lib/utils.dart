import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:starnet_login/JsonObjects/login_body.dart';
import 'package:starnet_login/JsonObjects/token_body.dart';

const String domain = "stis.starnet.cz";

Future<String?> getToken(String username, String password) async {
  LoginBody body = LoginBody(
      apiLoginForm: ApiLoginForm(
    username: username,
    password: password,
  ));
  var jsonBody = jsonEncode(body.toJson());
  Uri? url = Uri.tryParse("https://${domain}/api-token/create");

  http.Request request = http.Request("post", url!);
  request.body = jsonBody;
  request.headers.clear();
  request.headers.addAll({
    "content-type": "application/json",
    "accept": "application/stis+json;version=1",
  });

  var response = await request.send();
  if (response.statusCode != 200) {
    throw Exception("Neplatné přihlašovací údaje.");
  }

  var decodedResponse = await http.Response.fromStream(response);
  var tokenBody = TokenBody.fromJson(jsonDecode(decodedResponse.body));

  return tokenBody.token;
}

void showErrorToUser(e, context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: Colors.red,
        ),
        padding: const EdgeInsets.all(16.0),
        child: Text(e.toString())),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    duration: const Duration(days: 1),
    elevation: 0,
  ));
}
