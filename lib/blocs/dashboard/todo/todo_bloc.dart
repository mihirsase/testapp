import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/blocs/dashboard/todo/todo_event.dart';
import 'package:testapp/blocs/dashboard/todo/todo_state.dart';
import 'package:testapp/models/todo/todo.dart';
import 'package:testapp/models/todo/todo_repo.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoLoading());
  List<Todo> todoList = [];

  @override
  Stream<TodoState> mapEventToState(
      final TodoEvent event,
      ) async* {
    if (event is LoadTodo) {
      yield TodoLoading();

      final List<Todo>? _response = await TodoRepo.instance.getTodosForTheUser();
      if (_response != null) {
        todoList = _response;
      }
      yield TodoLoaded();
    }
  }
}
