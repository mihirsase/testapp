import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/blocs/dashboard/album/album_bloc.dart';
import 'package:testapp/blocs/dashboard/album/album_event.dart';
import 'package:testapp/blocs/dashboard/album/album_state.dart';
import 'package:testapp/components/atoms/form_atom.dart';
import 'package:testapp/components/atoms/loading_atom.dart';
import 'package:testapp/components/atoms/refresh_atom.dart';
import 'package:testapp/components/atoms/title_atom.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({Key? key}) : super(key: key);

  @override
  _AlbumScreenState createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  late AlbumBloc _albumBloc;

  @override
  void initState() {
    _albumBloc = BlocProvider.of<AlbumBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumBloc, AlbumState>(
      builder: (
          final BuildContext _,
          final AlbumState state,
          ) {
        return Scaffold(
          body: _body(state),
        );
      },
    );
  }

  Widget _body(final AlbumState state) {
    if (state is AlbumLoading) {
      return LoadingAtom(
        onRefresh: () async {
          _albumBloc.add(LoadAlbum());
        },
      );
    }

    return RefreshAtom(
      onRefresh: () async {
        _albumBloc.add(LoadAlbum());
      },
      child: FormAtom(
        isAlwaysScrollable: true,
        children: [
          TitleAtom(
            title: 'Albums',
            subtitle:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis posuere ex placerat vulputate condimentum.',
          ),
        ],
      ),
    );
  }
}
