import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_clone/bloc/tiktok_bloc.dart';
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
    return Scaffold(
      body: BlocBuilder<TiktokBloc, TiktokState>(
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
                      child: Text("No comments yet"),
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
                  .read<TiktokBloc>()
                  .add(PostCommentEvent(commentText: value, postId: videoId));
              _commentTextController.clear();
            }
          },
        ),
      ),
    );
  }
}
