import 'package:json_annotation/json_annotation.dart';

part 'current_user.g.dart';

@JsonSerializable()
class CurrentUser{
   String email;

  CurrentUser(this.email);

  factory CurrentUser.fromJson(Map<String, dynamic> json) => _$CurrentUserFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentUserToJson(this);
}