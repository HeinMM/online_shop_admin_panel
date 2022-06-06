// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostData _$PostDataFromJson(Map<String, dynamic> json) => PostData(
      id: json['id'] as int?,
      title: json['title'] as String?,
      price: json['price'] as String?,
      category_id: json['category_id'] as String?,
      dec: json['dec'] as String?,
      qty: json['qty'] as String?,
      post_images: (json['post_images'] as List<dynamic>?)
          ?.map((e) => GetImage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostDataToJson(PostData instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'category_id': instance.category_id,
      'price': instance.price,
      'dec': instance.dec,
      'qty': instance.qty,
      'post_images': instance.post_images,
    };
