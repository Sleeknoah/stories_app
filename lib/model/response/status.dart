import 'package:json_annotation/json_annotation.dart';

part 'status.g.dart';

@JsonSerializable()
class Status {
  String image;
  String bgColor;
  String timeStamp;
  String text;

  Status({
    required this.image,
    required this.text,
    required this.bgColor,
    required this.timeStamp,
  });

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);

  Map<String, dynamic> toJson() => _$StatusToJson(this);
}
