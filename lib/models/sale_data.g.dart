// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleData _$SaleDataFromJson(Map<String, dynamic> json) => SaleData(
      id: json['id'] as int?,
      title: json['title'] as String?,
      normal_price: json['normal_price'] as String?,
      sale_price: json['sale_price'] as String?,
      dec: json['dec'] as String?,
      qty: json['qty'] as String?,
      sale_images: (json['sale_images'] as List<dynamic>?)
          ?.map((e) => GetImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      waiting_time: json['waiting_time'] as String?,
    );

Map<String, dynamic> _$SaleDataToJson(SaleData instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'normal_price': instance.normal_price,
      'sale_price': instance.sale_price,
      'dec': instance.dec,
      'qty': instance.qty,
      'sale_images': instance.sale_images,
      'waiting_time': instance.waiting_time,
    };
