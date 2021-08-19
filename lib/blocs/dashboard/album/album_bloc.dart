import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/blocs/dashboard/album/album_event.dart';
import 'package:testapp/blocs/dashboard/album/album_state.dart';
import 'package:testapp/models/album/album.dart';
import 'package:testapp/models/album/album_repo.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  AlbumBloc() : super(AlbumLoading());
  List<Album> albumList = [];

  @override
  Stream<AlbumState> mapEventToState(
      final AlbumEvent event,
      ) async* {
    if (event is LoadAlbum) {
      yield AlbumLoading();

      final List<Album>? _response = await AlbumRepo.instance.getAlbums();
      if (_response != null) {
        albumList = _response;
      }
      yield AlbumLoaded();
    }
  }
}
