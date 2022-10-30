import 'package:json_annotation/json_annotation.dart';

import 'profile.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  Profile profile;

  Data({required this.profile});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
