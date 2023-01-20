import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@Freezed()
class User with _$User {
  const User._();

  const factory User({
    required String name,
    required String email,
    required String profilePhoto,
    required String uid,
    required int likes,
    required List following,
    required List followers,
    required List friends,
    required List currentlyLikedPosts,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      email: snapshot['email'],
      profilePhoto: snapshot['profilePhoto'],
      uid: snapshot['uid'],
      name: snapshot['name'],
      likes: snapshot['likes'],
      following: snapshot['following'],
      followers: snapshot['followers'],
      friends: snapshot['friends'],
      currentlyLikedPosts: snapshot['currentlyLikedPosts'],
    );
  }
}
