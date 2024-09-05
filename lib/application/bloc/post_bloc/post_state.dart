part of 'post_bloc.dart';

sealed class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

final class PostInitial extends PostState {}

final class PostLoading extends PostState {}

final class PostsLoaded extends PostState {
  final List<Post> posts;

  const PostsLoaded(this.posts);

  @override
  List<Object> get props => [posts];
}

final class PostLoaded extends PostState {
  final Post post;

  const PostLoaded(this.post);

  @override
  List<Object> get props => [post];
}

final class PostError extends PostState {
  final String message;

  const PostError(this.message);

  @override
  List<Object> get props => [message];
}
