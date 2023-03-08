import 'package:serializable/serializable.dart';

class LoginResponse implements Serializable {
  String? token;

  LoginResponse({this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(token: json["token"]);
  }

  Map<String, dynamic> toJson() {
    return {"token": this.token};
  }
}
