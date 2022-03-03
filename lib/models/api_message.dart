import 'package:json_annotation/json_annotation.dart';

part 'api_message.g.dart';

@JsonSerializable()
class ApiMessage{
  bool status;
  String message;
  bool isAdmin;
  String token;

  ApiMessage(this.status,this.message,this.isAdmin,this.token);

  factory ApiMessage.fromJson(Map<String, dynamic> json) => _$ApiMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ApiMessageToJson(this);
}