import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/blocs/dashboard/todo/todo_bloc.dart';
import 'package:testapp/blocs/dashboard/todo/todo_event.dart';
import 'package:testapp/blocs/dashboard/todo/todo_state.dart';
import 'package:testapp/components/atoms/form_atom.dart';
import 'package:testapp/components/atoms/loading_atom.dart';
import 'package:testapp/components/atoms/refresh_atom.dart';
import 'package:testapp/components/atoms/title_atom.dart';

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
        ],
      ),
    );
  }
}
