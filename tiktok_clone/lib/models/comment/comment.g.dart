// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Comment _$$_CommentFromJson(Map<String, dynamic> json) => _$_Comment(
      username: json['username'] as String,
      comment: json['comment'] as String,
      datePublished: const TimestampConverter()
          .fromJson(json['datePublished'] as Timestamp),
      likes: json['likes'] as List<dynamic>,
      profilePhoto: json['profilePhoto'] as String,
      uid: json['uid'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$$_CommentToJson(_$_Comment instance) =>
    <String, dynamic>{
      'username': instance.username,
      'comment': instance.comment,
      'datePublished':
          const TimestampConverter().toJson(instance.datePublished),
      'likes': instance.likes,
      'profilePhoto': instance.profilePhoto,
      'uid': instance.uid,
      'id': instance.id,
    };
