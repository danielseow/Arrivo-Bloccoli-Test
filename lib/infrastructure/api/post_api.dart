import 'package:arrivo_test/infrastructure/models/comment_model.dart';
import 'package:arrivo_test/infrastructure/models/post_model.dart';

import 'base_api.dart';

class PostAPI {
  final BaseAPI _baseAPI;

  PostAPI(this._baseAPI);

  Future<List<PostModel>> getPosts() async {
    final response = await _baseAPI.get('/posts');
    return (response as List).map((json) => PostModel.fromJson(json)).toList();
  }

  Future<PostModel> getPost(int id) async {
    final response = await _baseAPI.get('/posts/$id');
    return PostModel.fromJson(response);
  }

  Future<List<CommentModel>> getComments(int postId) async {
    final response = await _baseAPI.get('/posts/$postId/comments');
    return (response as List)
        .map((json) => CommentModel.fromJson(json))
        .toList();
  }
}
