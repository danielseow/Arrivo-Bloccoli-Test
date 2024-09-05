import 'package:arrivo_test/application/usecases/get_posts.dart';
import 'package:arrivo_test/domain/entities/comment.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final PostUseCases postUseCases;
  CommentBloc({required this.postUseCases}) : super(CommentInitial()) {
    on<FetchComments>(_onFetchComments);
  }

  void _onFetchComments(FetchComments event, Emitter<CommentState> emit) async {
    emit(CommentsLoading());
    try {
      final comments = await postUseCases.getComments(event.postId);
      emit(CommentsLoaded(comments));
    } catch (e) {
      emit(CommentsError(e.toString()));
    }
  }
}
