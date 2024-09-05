part of 'comment_bloc.dart';

sealed class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

final class CommentInitial extends CommentState {}

final class CommentsLoading extends CommentState {}

final class CommentsLoaded extends CommentState {
  final List<Comment> comments;

  const CommentsLoaded(this.comments);

  @override
  List<Object> get props => [comments];
}

final class CommentsError extends CommentState {
  final String message;

  const CommentsError(this.message);

  @override
  List<Object> get props => [message];
}
