// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Status _$StatusFromJson(Map<String, dynamic> json) => Status(
      image: json['image'] as String,
      text: json['text'] as String,
      bgColor: json['bgColor'] as String,
      timeStamp: json['timeStamp'] as String,
    );

Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
      'image': instance.image,
      'bgColor': instance.bgColor,
      'timeStamp': instance.timeStamp,
      'text': instance.text,
    };
