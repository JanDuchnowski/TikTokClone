import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiktok_clone/comment/comment_controller.dart';
import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/models/comment/comment.dart';
import 'package:tiktok_clone/comment/widgets/comment_widget.dart';

class CommentScreen extends StatelessWidget {
  CommentScreen({Key? key, required this.videoId}) : super(key: key);

  final String videoId;
  final TextEditingController _commentTextController = TextEditingController();
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
            .orderBy("datePublished")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Text("Snapshot does not have data");
          }

          return ListView(
            shrinkWrap: true,
            children: snapshot != null
                ? snapshot.data!.docs.map((document) {
                    final currentComment = Comment.fromJson(
                        document.data() as Map<String, dynamic>);

                    return CommentWidget(
                      comment: currentComment,
                      commentController: commentController,
                    );
                  }).toList()
                : [
                    Container(
                      child: Text("No comments yet"),
                    )
                  ],
          );
        },
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width - 10,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        ),
        child: TextField(
          controller: _commentTextController,
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              commentController.postComment(value);
              _commentTextController.clear();
            }
          },
        ),
      ),
    );
  }
}
