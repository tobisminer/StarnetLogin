class TokenBody {
  String? token;

  TokenBody({this.token});

  TokenBody.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

}