class TokenBody {
  ApiLoginForm? apiLoginForm;

  TokenBody({this.apiLoginForm});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.apiLoginForm != null) {
      data['api_login_form'] = this.apiLoginForm!.toJson();
    }
    return data;
  }
}

class ApiLoginForm {
  String? username;
  String? password;
  Attr? attr;

  ApiLoginForm({this.username, this.password, this.attr});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    if (this.attr != null) {
      data['attr'] = this.attr!.toJson();
    }
    return data;
  }
}

class Attr {
  String? androidOsVersion;
  String? appTechnikVersion;
  String? imei;

  Attr({this.androidOsVersion, this.appTechnikVersion, this.imei});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['androidOsVersion'] = this.androidOsVersion;
    data['appTechnikVersion'] = this.appTechnikVersion;
    data['imei'] = this.imei;
    return data;
  }
}