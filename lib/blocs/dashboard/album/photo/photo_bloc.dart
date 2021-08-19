import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/blocs/dashboard/album/photo/photo_event.dart';
import 'package:testapp/blocs/dashboard/album/photo/photo_state.dart';
import 'package:testapp/models/album/album.dart';
import 'package:testapp/models/album/album_repo.dart';
import 'package:testapp/models/album/photo/photo.dart';
import 'package:testapp/services/notifier.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final Album album;

  PhotoBloc({
    required this.album,
  }) : super(PhotoLoading());
  List<Photo> photoList = [];

  @override
  Stream<PhotoState> mapEventToState(
    final PhotoEvent event,
  ) async* {
    if (event is LoadPhoto) {
      yield PhotoLoading();

      if (album.id != null) {
        final List<Photo>? _response = await AlbumRepo.instance.getPhotosForAlbum(
          albumId: album.id!,
        );
        if (_response != null) {
          photoList = _response;
        }
      } else {
        Notifier.instance.alert(
          title: 'Not able to load photos',
          notifType: NotifType.negative,
        );
      }
      yield PhotoLoaded();
    }
  }
}
