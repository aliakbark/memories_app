// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:memories_app/src/models/base_response_header.dart';

import 'package:authentication/authentication.dart';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  const LoginResponse({
    this.responseHeader,
    this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        responseHeader: json['responseHeader'] == null
            ? null
            : BaseResponseHeader.fromJson(json['responseHeader']),
        user: json['user'] == null ? null : User.fromJson(json['user']),
      );

  final BaseResponseHeader? responseHeader;
  final User? user;

  Map<String, dynamic> toJson() => {
        'responseHeader':
            responseHeader == null ? null : responseHeader?.toJson(),
        'user': user == null ? null : user?.toJson(),
      };
}
