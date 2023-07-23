class LoginBody {
  ApiLoginForm? apiLoginForm;

  LoginBody({this.apiLoginForm});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (apiLoginForm != null) {
      data['api_login_form'] = apiLoginForm!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    if (attr != null) {
      data['attr'] = attr!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['androidOsVersion'] = androidOsVersion;
    data['appTechnikVersion'] = appTechnikVersion;
    data['imei'] = imei;
    return data;
  }
}
