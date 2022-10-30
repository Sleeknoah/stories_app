import 'package:json_annotation/json_annotation.dart';

import 'friends.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {
  int id;
  String name;
  String picture;
  List<Friends> friends;

  Profile({
    required this.id,
    required this.name,
    required this.picture,
    required this.friends,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
