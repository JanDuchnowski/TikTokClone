// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      name: json['name'] as String,
      email: json['email'] as String,
      profilePhoto: json['profilePhoto'] as String,
      uid: json['uid'] as String,
      likes: json['likes'] as int,
      following: json['following'] as List<dynamic>,
      followers: json['followers'] as List<dynamic>,
      friends: json['friends'] as List<dynamic>,
      currentlyLikedPosts: json['currentlyLikedPosts'] as List<dynamic>,
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'profilePhoto': instance.profilePhoto,
      'uid': instance.uid,
      'likes': instance.likes,
      'following': instance.following,
      'followers': instance.followers,
      'friends': instance.friends,
      'currentlyLikedPosts': instance.currentlyLikedPosts,
    };
