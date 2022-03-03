import 'package:json_annotation/json_annotation.dart';

part 'search_data.g.dart';

@JsonSerializable()
class SearchData{
  String search;

  SearchData(this.search);

  factory SearchData.fromJson(Map<String, dynamic> json) => _$SearchDataFromJson(json);

  Map<String, dynamic> toJson() => _$SearchDataToJson(this);
}