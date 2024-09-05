part of 'post_bloc.dart';

sealed class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

final class FetchPosts extends PostEvent {}

final class FetchPost extends PostEvent {
  final int id;

  const FetchPost(this.id);

  @override
  List<Object> get props => [id];
}

final class SearchPosts extends PostEvent {
  final String search;

  const SearchPosts(this.search);

  @override
  List<Object> get props => [search];
}
