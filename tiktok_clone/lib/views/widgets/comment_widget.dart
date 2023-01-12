import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiktok_clone/models/comment.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentWidget extends StatelessWidget {
  const CommentWidget({Key? key, required this.comment}) : super(key: key);

  final Comment comment;
  @override
  Widget build(BuildContext context) {
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
              comment.datePublished.toDate(),
            ),
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            '${comment.likes.length} likes',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
