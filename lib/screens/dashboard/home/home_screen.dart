import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/blocs/dashboard/home/home_bloc.dart';
import 'package:testapp/blocs/dashboard/home/home_event.dart';
import 'package:testapp/blocs/dashboard/home/home_state.dart';
import 'package:testapp/components/atoms/form_atom.dart';
import 'package:testapp/components/atoms/loading_atom.dart';
import 'package:testapp/components/atoms/refresh_atom.dart';
import 'package:testapp/components/atoms/title_atom.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc _homeBloc;

  @override
  void initState() {
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (
        final BuildContext _,
        final HomeState state,
      ) {
        return Scaffold(
          body: _body(state),
        );
      },
    );
  }

  Widget _body(final HomeState state) {
    if (state is HomeLoading) {
      return LoadingAtom(
        onRefresh: () async {
          _homeBloc.add(LoadHome());
        },
      );
    }

    return RefreshAtom(
      onRefresh: () async {
        _homeBloc.add(LoadHome());
      },
      child: FormAtom(
        isAlwaysScrollable: true,
        children: [
          TitleAtom(
            title: 'Posts',
            subtitle:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis posuere ex placerat vulputate condimentum.',
          ),
        ],
      ),
    );
  }
}
