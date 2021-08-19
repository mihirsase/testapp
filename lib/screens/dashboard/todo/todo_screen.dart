import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/blocs/dashboard/todo/todo_bloc.dart';
import 'package:testapp/blocs/dashboard/todo/todo_event.dart';
import 'package:testapp/blocs/dashboard/todo/todo_state.dart';
import 'package:testapp/components/atoms/form_atom.dart';
import 'package:testapp/components/atoms/loading_atom.dart';
import 'package:testapp/components/atoms/margin_atom.dart';
import 'package:testapp/components/atoms/refresh_atom.dart';
import 'package:testapp/components/atoms/title_atom.dart';
import 'package:testapp/models/todo/todo.dart';
import 'package:testapp/services/pallete.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  late TodoBloc _todoBloc;

  @override
  void initState() {
    _todoBloc = BlocProvider.of<TodoBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (
        final BuildContext _,
        final TodoState state,
      ) {
        return Scaffold(
          body: _body(state),
        );
      },
    );
  }

  Widget _body(final TodoState state) {
    if (state is TodoLoading) {
      return LoadingAtom(
        onRefresh: () async {
          _todoBloc.add(LoadTodo());
        },
      );
    }

    return RefreshAtom(
      onRefresh: () async {
        _todoBloc.add(LoadTodo());
      },
      child: FormAtom(
        isAlwaysScrollable: true,
        children: [
          TitleAtom(
            title: 'To do list',
            subtitle:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis posuere ex placerat vulputate condimentum.',
          ),
          ..._todoBloc.todoList.map((final Todo todo) => _todoTile(todo)).toList(),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }

  Widget _todoTile(final Todo todo) {
    return Padding(
      padding: EdgeInsets.fromLTRB(MarginAtom.padding(context), 12, MarginAtom.padding(context), 0),
      child: Card(
        color: Pallete.secondaryBackground,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          title: Text(
            todo.title ?? '',
            style: TextStyle(
              color: Pallete.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          subtitle: Text(
            todo.completed == true ? 'Completed' : 'Incomplete',
            style: TextStyle(
              color: todo.completed == true ? Pallete.green : Pallete.red,
            ),
          ),
        ),
      ),
    );
  }
}
