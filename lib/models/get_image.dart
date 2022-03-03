import 'package:json_annotation/json_annotation.dart';

part 'get_image.g.dart';

@JsonSerializable()
class GetImage{
  String? file_path;

  GetImage(this.file_path,);

  factory GetImage.fromJson(Map<String, dynamic> json) => _$GetImageFromJson(json);

  Map<String, dynamic> toJson() => _$GetImageToJson(this);
}