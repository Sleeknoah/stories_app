import 'package:json_annotation/json_annotation.dart';
import 'package:stories_app/model/response/status.dart';

part 'friends.g.dart';

@JsonSerializable()
class Friends {
  int? id;
  String name;
  String picture;
  List<Status> status;

  Friends({
    this.id,
    required this.name,
    required this.picture,
    required this.status,
  });

  factory Friends.fromJson(Map<String, dynamic> json) =>
      _$FriendsFromJson(json);

  Map<String, dynamic> toJson() => _$FriendsToJson(this);
}
