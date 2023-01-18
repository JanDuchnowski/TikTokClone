import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tiktok_clone/models/comment/timestamp_converter.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@Freezed()
class Comment with _$Comment {
  const Comment._();

  factory Comment({
    required String username,
    required String comment,
    @TimestampConverter() required DateTime datePublished,
    required List likes,
    required String profilePhoto,
    required String uid,
    required String id,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  static Comment fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Comment(
      username: snapshot['username'],
      comment: snapshot['comment'],
      datePublished: snapshot['datePublished'],
      likes: snapshot['likes'],
      profilePhoto: snapshot['profilePhoto'],
      uid: snapshot['uid'],
      id: snapshot['id'],
    );
  }
}
