import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/blocs/dashboard/album/photo/photo_bloc.dart';
import 'package:testapp/blocs/dashboard/album/photo/photo_event.dart';
import 'package:testapp/blocs/dashboard/album/photo/photo_state.dart';
import 'package:testapp/components/atoms/loading_atom.dart';
import 'package:testapp/components/atoms/margin_atom.dart';
import 'package:testapp/components/atoms/refresh_atom.dart';
import 'package:testapp/models/album/album.dart';
import 'package:testapp/models/album/photo/photo.dart';
import 'package:testapp/services/pallete.dart';

class PhotoScreen extends StatefulWidget {
  final Album album;

  const PhotoScreen({
    required this.album,
  });

  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  late PhotoBloc _photoBloc;

  @override
  void initState() {
    _photoBloc = PhotoBloc(
      album: widget.album,
    );
    _photoBloc.add(LoadPhoto());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PhotoBloc>(
      create: (final BuildContext _) {
        return _photoBloc;
      },
      child: BlocBuilder<PhotoBloc, PhotoState>(
        builder: (
          final BuildContext _,
          final PhotoState state,
        ) {
          return SafeArea(
            top: false,
            child: Scaffold(
              appBar: _appBar as PreferredSizeWidget?,
              body: _body(state),
            ),
          );
        },
      ),
    );
  }

  Widget get _appBar {
    return AppBar(
      backgroundColor: Pallete.secondaryBackground,
      title: Text(
        widget.album.title ?? '',
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _body(final PhotoState state) {
    if (state is PhotoLoading) {
      return Center(
        child: LoadingAtom(),
      );
    }
    return RefreshAtom(
      onRefresh: () async {
        _photoBloc.add(LoadPhoto());
      },
      child: MarginAtom(
        child: ListView(
          children: [
            ..._photoBloc.photoList.map((final Photo photo) => _photoTile(photo)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _photoTile(final Photo photo) {
    return Padding(
      padding: EdgeInsets.only(top: 12),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Pallete.secondaryBackground,
        child: Column(
          children: [
            if (photo.url != null)
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  photo.url!,
                  loadingBuilder:
                      (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return LoadingAtom();
                  },
                ),
              ),
            ListTile(
              title: Text(
                photo.title ?? '',
                style: TextStyle(
                  color: Pallete.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
