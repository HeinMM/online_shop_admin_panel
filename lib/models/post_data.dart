// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:one_two_one_admin/models/get_image.dart';

part 'post_data.g.dart';

@JsonSerializable()
class PostData {
  int? id;
  String? title;
  String? category_id;
  String? price;
  String? dec;
  String? qty;
   List<GetImage>? post_images;
 

  PostData(
      {@required this.id,
      @required this.title,
      @required this.price,
      @required this.category_id,
      @required this.dec,
      @required this.qty,
       @required this.post_images,
     });

  factory PostData.fromJson(Map<String, dynamic> json) =>
      _$PostDataFromJson(json);

  Map<String, dynamic> toJson() => _$PostDataToJson(this);
}
