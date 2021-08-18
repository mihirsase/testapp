import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/blocs/dashboard/todo/todo_event.dart';
import 'package:testapp/blocs/dashboard/todo/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoLoading());

  @override
  Stream<TodoState> mapEventToState(
      final TodoEvent event,
      ) async* {
    if (event is LoadTodo) {
      yield TodoLoading();


      yield TodoLoaded();
    }
  }
}
