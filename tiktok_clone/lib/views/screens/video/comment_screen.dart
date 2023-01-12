import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiktok_clone/controllers/comment_controller.dart';
import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/models/comment.dart';
import 'package:tiktok_clone/views/widgets/comment_widget.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen(
      {Key? key, required this.videoId, required this.commentList})
      : super(key: key);

  final String videoId;
  final List<dynamic> commentList;

  @override
  Widget build(BuildContext context) {
    final CommentController commentController =
        CommentController(postId: videoId);
    return Scaffold(
      body: StreamBuilder(
          stream: Storage()
              .firestore
              .collection('posts')
              .doc(videoId)
              .collection('comments')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            // Check for errors
            if (!snapshot.hasData) {
              return Container(child: Text("Snapshot does not have data"));
            }

            return Column(
              children: [
                ListView(
                  shrinkWrap: true,
                  children: snapshot != null
                      ? snapshot.data!.docs.map((document) {
                          final currentComment = Comment.fromSnap(document);

                          return Container(
                            child: CommentWidget(
                              comment: currentComment,
                            ),
                          );
                        }).toList()
                      : [
                          Container(
                            child: Text("No comments yet"),
                          )
                        ],
                ),
                TextField(
                  onSubmitted: (value) {
                    commentController.postComment(value);
                  },
                ),
              ],
            );
          }),
    );
  }
}
