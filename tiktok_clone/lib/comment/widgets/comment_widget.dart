import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiktok_clone/comment/comment_controller.dart';
import 'package:tiktok_clone/models/comment/comment.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentWidget extends StatelessWidget {
  const CommentWidget(
      {Key? key, required this.comment, required this.commentController})
      : super(key: key);

  final Comment comment;
  final CommentController commentController;
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return ListTile(
      leading:
          CircleAvatar(foregroundImage: NetworkImage(comment.profilePhoto)),
      title: Row(
        children: [
          Text(
            "${comment.username}  ",
            style: const TextStyle(
              fontSize: 20,
              color: Colors.red,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            comment.comment,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      subtitle: Row(
        children: [
          Text(
            timeago.format(
              comment.datePublished,
            ),
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () {
              commentController.incrementCommentLikes(comment.id);
            },
            icon: const Icon(
              Icons.favorite,
              // color: ,
            ),
          ),
          Text(
            '${comment.likes.length} likes',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
