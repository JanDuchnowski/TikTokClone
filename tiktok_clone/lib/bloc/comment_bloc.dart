import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tiktok_clone/models/comment/comment.dart';
import 'package:tiktok_clone/repository/comment_repository.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepositoryInterface _commentRepository;
  CommentBloc(this._commentRepository) : super(CommentState()) {
    on<CommentEvent>((event, emit) async {
      if (event is FetchCommentsEvent) {
        final Stream<QuerySnapshot<Map<String, dynamic>>>? commentStream =
            _commentRepository.getCommentStream(event.postId);
        await emit.forEach(commentStream!,
            onData: ((QuerySnapshot<Map<String, dynamic>> data) {
          return state.copyWith(commentQuery: data);
        }));
      } else if (event is PostCommentEvent) {
        _commentRepository.postComment(event.commentText, event.postId);
      } else if (event is LikeCommentEvent) {
        _commentRepository.likeComment(event.commentId, event.postId);
      }
    });
  }
}
