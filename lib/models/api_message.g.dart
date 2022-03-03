// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiMessage _$ApiMessageFromJson(Map<String, dynamic> json) => ApiMessage(
      json['status'] as bool,
      json['message'] as String,
      json['isAdmin'] as bool,
      json['token'] as String,
    );

Map<String, dynamic> _$ApiMessageToJson(ApiMessage instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'isAdmin': instance.isAdmin,
      'token': instance.token,
    };
