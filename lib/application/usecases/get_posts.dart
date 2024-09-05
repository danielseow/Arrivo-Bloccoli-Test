import 'package:arrivo_test/domain/entities/comment.dart';
import 'package:arrivo_test/domain/entities/post.dart';
import 'package:arrivo_test/domain/repositories/post_repository.dart';

class PostUseCases {
  final PostRepository repository;

  PostUseCases(this.repository);

  Future<List<Post>> getPosts() async {
    return await repository.getPosts();
  }

  Future<Post> getPost(int id) async {
    return await repository.getPost(id);
  }

  Future<List<Comment>> getComments(int postId) async {
    return await repository.getComments(postId);
  }
}
