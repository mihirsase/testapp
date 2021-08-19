import 'package:dio/dio.dart';
import 'package:testapp/models/post/comment/comment.dart';
import 'package:testapp/models/post/post.dart';
import 'package:testapp/services/api_requester.dart';

class PostRepo {
  static final PostRepo instance = PostRepo._();

  PostRepo._();

  Future<List<Post>?> getPosts() async {
    try {
      Response response =
          await APIRequester.instance.dio.get('https://jsonplaceholder.typicode.com/posts');
      return Post.listFromMap(response.data);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Comment>?> getCommentsFromPost({required int postId}) async {
    try {
      Response response =
      await APIRequester.instance.dio.get('https://jsonplaceholder.typicode.com/comments?postId=$postId');
      return Comment.listFromMap(response.data);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
