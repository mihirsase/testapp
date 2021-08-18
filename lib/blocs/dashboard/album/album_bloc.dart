import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/blocs/dashboard/album/album_event.dart';
import 'package:testapp/blocs/dashboard/album/album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  AlbumBloc() : super(AlbumLoading());

  @override
  Stream<AlbumState> mapEventToState(
      final AlbumEvent event,
      ) async* {
    if (event is LoadAlbum) {
      yield AlbumLoading();


      yield AlbumLoaded();
    }
  }
}
