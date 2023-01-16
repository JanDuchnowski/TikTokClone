import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String email;
  String profilePhoto;
  String uid;
  int likes;
  List following;
  List followers;

  User({
    required this.name,
    required this.email,
    required this.profilePhoto,
    required this.uid,
    required this.likes,
    required this.following,
    required this.followers,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "profilePhoto": profilePhoto,
        "uid": uid,
        "likes": likes,
        "following": following,
        "followers": followers,
      };

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
    );
  }
}
