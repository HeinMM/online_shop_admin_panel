import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'staff_for_login.g.dart';

@JsonSerializable()
class StaffForLogin{
  String? password;
  String? email;
  StaffForLogin(  {@required this.email,@required this.password});

  factory StaffForLogin.fromJson(Map<String, dynamic> json) => _$StaffForLoginFromJson(json);

  Map<String, dynamic> toJson() => _$StaffForLoginToJson(this);
}