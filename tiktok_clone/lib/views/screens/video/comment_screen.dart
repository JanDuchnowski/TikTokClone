import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiktok_clone/controllers/comment_controller.dart';
import 'package:tiktok_clone/firebase/storage.dart';

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
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: commentList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(commentList[index].toString()),
              );
            },
          ),
          TextField(
            onSubmitted: (value) {
              commentController.postComment(value);
            },
          ),
        ],
      ),
    );
  }
}
