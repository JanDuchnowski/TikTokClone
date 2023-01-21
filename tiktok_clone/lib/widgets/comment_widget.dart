import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_clone/bloc/comment/comment_bloc.dart';
import 'package:tiktok_clone/bloc/tiktok/tiktok_bloc.dart';
import 'package:tiktok_clone/models/comment/comment.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentWidget extends StatelessWidget {
  const CommentWidget({Key? key, required this.comment, required this.postId})
      : super(key: key);

  final Comment comment;

  final String postId;
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return ListTile(
      leading: CircleAvatar(
          foregroundImage: Image.network(
        comment.profilePhoto,
        errorBuilder:
            (BuildContext contex, Object object, StackTrace? stackTrace) {
          return Text("Error fetching profile photo");
        },
      ).image),
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
              context
                  .read<CommentBloc>()
                  .add(LikeCommentEvent(commentId: comment.id, postId: postId));
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
