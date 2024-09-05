import 'package:arrivo_test/application/usecases/get_posts.dart';
import 'package:arrivo_test/domain/entities/post.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostUseCases postUseCases;
  List<Post> _allPosts = []; // Add this line

  PostBloc({required this.postUseCases}) : super(PostInitial()) {
    on<FetchPost>(_onFetchPost);
    on<FetchPosts>(_onFetchPosts);
    on<SearchPosts>(_onSearchPosts);
  }

  void _onFetchPosts(FetchPosts event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      _allPosts = await postUseCases.getPosts();
      emit(PostsLoaded(_allPosts));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  void _onFetchPost(FetchPost event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      final post = await postUseCases.getPost(event.id);
      emit(PostLoaded(post));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  void _onSearchPosts(SearchPosts event, Emitter<PostState> emit) {
    emit(PostLoading());
    try {
      final searchTerm = event.search.toLowerCase();
      final filteredPosts = _allPosts
          .where((post) =>
              post.id.toString().contains(searchTerm) ||
              post.title.toLowerCase().contains(searchTerm) ||
              post.body.toLowerCase().contains(searchTerm))
          .toList();
      emit(PostsLoaded(filteredPosts));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }
}
