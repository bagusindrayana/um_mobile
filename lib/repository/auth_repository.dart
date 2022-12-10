import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:um_mobile/provider/api_provider.dart';

//make model login response
class LoginResponse {
  String? token;
  String? message;
  int? status;

  LoginResponse({this.token, this.message, this.status});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    message = json['message'];
    status = json['status'] ?? null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class LogoutResponse {
  String? message;
  int? status;

  LogoutResponse({this.message, this.status});

  LogoutResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'] ?? null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class AuthRepository {
  //auth function with parameter username and password and save token to FlutterSecureStorage
  Future<LoginResponse> auth(String username, String password) async {
    try {
      var url = "https://scraping-um-node-js.vercel.app/siam/login";
      var response = await ApiProvider.post(
          url, {"username": username, "password": password}, null);

      if (response.statusCode == 200) {
        final storage = new FlutterSecureStorage();
        await persistToken(response.data[1]);
        return LoginResponse(
            status: 200, message: "Login berhasil", token: response.data[1]);
      }

      return LoginResponse(status: 402, message: response.data);
    } catch (e) {
      if (e is DioError) {
        var response = e.response;
        if (response == null) {
          return LoginResponse(message: "Error : ${e}");
        } else if (response.data != null) {
          return LoginResponse(message: "Error", status: 500);
        }
        return LoginResponse(message: "Error : ${e.message}", status: 500);
      } else {
        return LoginResponse(message: "Error : Uknown", status: 500);
      }
    }
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    // await Future.delayed(Duration(seconds: 1));
    final storage = new FlutterSecureStorage();
    await storage.delete(key: "_cookie_token");
    return;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    // await Future.delayed(Duration(seconds: 1));
    final storage = new FlutterSecureStorage();
    await storage.write(key: "_cookie_token", value: token);
    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    // await Future.delayed(Duration(seconds: 1));
    final storage = new FlutterSecureStorage();
    String? token = await storage.read(key: "_cookie_token");
    return (token != null && token != "") ? true : false;
  }

  Future<String?> getToken() async {
    /// read from keystore/keychain
    // await Future.delayed(Duration(seconds: 1));
    final storage = new FlutterSecureStorage();
    String? token = await storage.read(key: "_cookie_token");
    return token;
  }

  //post logout route and delete token
  Future<LogoutResponse> logout() async {
    try {
      String? token = await getToken();
      if (token == null) {
        return LogoutResponse(message: "Error : Token not found", status: 200);
      }

      // var url = "logout";
      // var response =
      //     await ApiProvider.get(url, {"Authorization": "Bearer $token"});

      // if (response.statusCode == 200) {
      //   await deleteToken();
      // }
      await deleteToken();

      return LogoutResponse(status: 200, message: "Logout berhasil");
    } catch (e) {
      if (e is DioError) {
        var response = e.response;
        if (response == null) {
          return LogoutResponse(message: "Error : ${e}");
        } else if (response.data != null) {
          try {
            return LogoutResponse.fromJson(response.data);
          } catch (e) {
            return LogoutResponse(message: "Error");
          }
        }
        return LogoutResponse(message: "Error : ${e.message}");
      } else {
        return LogoutResponse(message: "Error : Uknown");
      }
    }
  }
}
