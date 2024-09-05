part of 'comment_bloc.dart';

sealed class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

final class FetchComments extends CommentEvent {
  final int postId;

  const FetchComments(this.postId);

  @override
  List<Object> get props => [postId];
}
