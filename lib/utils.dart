import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:starnet_login/login_body.dart';
import 'package:starnet_login/token_body.dart';

const String domain = "https://stis.starnet.cz/";

Future<String?> getToken(String username, String password) async{
  LoginBody body = LoginBody(apiLoginForm: ApiLoginForm(username: username, password: password, attr: Attr(androidOsVersion: "9.1", appTechnikVersion: "1.23", imei: "1246543365434")));
  var jsonBody = jsonEncode(body.toJson());
  Uri? url = Uri.tryParse("${domain}api-token/create");

  http.Request request = http.Request("post", url!);
  request.body = jsonBody;
  request.headers.clear();
  request.headers.addAll({
    "content-type":"application/json",
    "accept":"application/stis+json;version=1",});

  var response = await request.send();
  var decodedResponse = await http.Response.fromStream(response);
  var tokenBody = TokenBody.fromJson(jsonDecode(decodedResponse.body));

  return tokenBody.token;
}