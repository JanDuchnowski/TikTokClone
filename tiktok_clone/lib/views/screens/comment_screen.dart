import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_clone/bloc/comment/comment_bloc.dart';

import 'package:tiktok_clone/models/comment/comment.dart';
import 'package:tiktok_clone/widgets/comment_widget.dart';

class CommentScreen extends StatelessWidget {
  CommentScreen({Key? key, required this.videoId}) : super(key: key);

  final String videoId;
  final TextEditingController _commentTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CommentBloc, CommentState>(
        builder: ((context, state) {
          return ListView(
            shrinkWrap: true,
            children: state.commentQuery != null
                ? state.commentQuery!.docs.map((document) {
                    final currentComment = Comment.fromJson(document.data());

                    return CommentWidget(
                      comment: currentComment,
                      postId: videoId,
                    );
                  }).toList()
                : [
                    Container(
                      child: const Text("No comments yet"),
                    )
                  ],
          );
        }),
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
              context
                  .read<CommentBloc>()
                  .add(PostCommentEvent(commentText: value, postId: videoId));
              _commentTextController.clear();
            }
          },
        ),
      ),
    );
  }
}
