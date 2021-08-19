import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/blocs/dashboard/home/home_bloc.dart';
import 'package:testapp/blocs/dashboard/home/home_event.dart';
import 'package:testapp/blocs/dashboard/home/home_state.dart';
import 'package:testapp/components/atoms/loading_atom.dart';
import 'package:testapp/components/atoms/margin_atom.dart';
import 'package:testapp/components/atoms/refresh_atom.dart';
import 'package:testapp/components/atoms/title_atom.dart';
import 'package:testapp/models/post/post.dart';
import 'package:testapp/services/pallete.dart';
import 'package:testapp/services/wayfinder.dart';

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
          floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.add,
              size: 32,
            ),
            onPressed: () {},
            backgroundColor: Pallete.green,
          ),
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
      child: ListView(
        children: [
          TitleAtom(
            title: 'Posts',
            subtitle:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis posuere ex placerat vulputate condimentum.',
          ),
          ..._homeBloc.postList.map((final Post post) => _postTile(post)).toList(),
        ],
      ),
    );
  }

  Widget _postTile(final Post post) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: MarginAtom.padding(context)),
        title: Text(
          post.title ?? '',
          style: TextStyle(
            color: Pallete.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Column(
          children: [
            SizedBox(
              height: 2,
            ),
            Text(
              post.body?.replaceAll('\n', '') ?? '',
              style: TextStyle(color: Pallete.greyLight),
            ),
            SizedBox(
              height: 4,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  Wayfinder.instance.comments(post: post);
                },
                child: Text(
                  'view comments',
                  style: TextStyle(
                    color: Pallete.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
