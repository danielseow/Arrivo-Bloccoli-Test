import 'package:arrivo_test/domain/entities/comment.dart';
import 'package:arrivo_test/domain/entities/post.dart';

abstract class PostRepository {
  Future<List<Post>> getPosts();
  Future<Post> getPost(int id);
  Future<List<Comment>> getComments(int postId);
}

/// https://stackoverflow.com/questions/3499119/which-layer-should-repositories-go-in
