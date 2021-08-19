import 'package:dio/dio.dart';
import 'package:testapp/models/todo/todo.dart';
import 'package:testapp/services/api_requester.dart';
import 'package:testapp/services/storage.dart';

class TodoRepo {
  static final TodoRepo instance = TodoRepo._();

  TodoRepo._();

  Future<List<Todo>?> getTodosForTheUser() async {
    try {
      Response response = await APIRequester.instance.dio
          .get('https://jsonplaceholder.typicode.com/users/${Storage.instance.userID}/todos');
      return Todo.listFromMap(response.data);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
