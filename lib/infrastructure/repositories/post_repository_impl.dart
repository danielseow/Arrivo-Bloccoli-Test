import 'package:arrivo_test/domain/entities/comment.dart';
import 'package:arrivo_test/domain/entities/post.dart';
import 'package:arrivo_test/domain/repositories/post_repository.dart';
import 'package:arrivo_test/infrastructure/api/post_api.dart';

/// Post repository implementation
class PostRepositoryImpl implements PostRepository {
  final PostAPI _postAPI;

  PostRepositoryImpl(this._postAPI);

  @override
  Future<List<Post>> getPosts() async {
    final postModels = await _postAPI.getPosts();
    return postModels;
  }

  @override
  Future<Post> getPost(int id) async {
    return await _postAPI.getPost(id);
  }

  @override
  Future<List<Comment>> getComments(int postId) async {
    return await _postAPI.getComments(postId);
  }
}

/// https://stackoverflow.com/questions/3499119/which-layer-should-repositories-go-in
