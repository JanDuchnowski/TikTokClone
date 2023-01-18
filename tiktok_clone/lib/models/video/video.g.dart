// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Video _$$_VideoFromJson(Map<String, dynamic> json) => _$_Video(
      username: json['username'] as String,
      uid: json['uid'] as String,
      id: json['id'] as String,
      likes: json['likes'] as List<dynamic>,
      commentCount: json['commentCount'] as int,
      shareCount: json['shareCount'] as int,
      comments: json['comments'] as List<dynamic>,
      songName: json['songName'] as String,
      caption: json['caption'] as String,
      videoUrl: json['videoUrl'] as String,
      profilePhoto: json['profilePhoto'] as String,
    );

Map<String, dynamic> _$$_VideoToJson(_$_Video instance) => <String, dynamic>{
      'username': instance.username,
      'uid': instance.uid,
      'id': instance.id,
      'likes': instance.likes,
      'commentCount': instance.commentCount,
      'shareCount': instance.shareCount,
      'comments': instance.comments,
      'songName': instance.songName,
      'caption': instance.caption,
      'videoUrl': instance.videoUrl,
      'profilePhoto': instance.profilePhoto,
    };
