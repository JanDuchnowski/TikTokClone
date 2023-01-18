import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'video.freezed.dart';
part 'video.g.dart';

@Freezed()
class Video with _$Video {
  const Video._();

  const factory Video({
    required String username,
    required String uid,
    required String id,
    required List likes,
    required int commentCount,
    required int shareCount,
    required List comments,
    required String songName,
    required String caption,
    required String videoUrl,
    required String profilePhoto,
  }) = _Video;

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

  static Video fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Video(
      username: snapshot['username'],
      uid: snapshot['uid'],
      id: snapshot['id'],
      likes: snapshot['likes'],
      commentCount: snapshot['commentCount'],
      shareCount: snapshot['shareCount'],
      comments: snapshot['comments'],
      songName: snapshot['songName'],
      caption: snapshot['caption'],
      videoUrl: snapshot['videoUrl'],
      profilePhoto: snapshot['profilePhoto'],
    );
  }
}
