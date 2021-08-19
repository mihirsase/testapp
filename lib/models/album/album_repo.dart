import 'package:dio/dio.dart';
import 'package:testapp/models/album/album.dart';
import 'package:testapp/models/album/photo/photo.dart';
import 'package:testapp/services/api_requester.dart';

class AlbumRepo {
  static final AlbumRepo instance = AlbumRepo._();

  AlbumRepo._();

  Future<List<Album>?> getAlbums() async {
    try {
      Response response =
          await APIRequester.instance.dio.get('https://jsonplaceholder.typicode.com/albums');
      return Album.listFromMap(response.data);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Photo>?> getPhotosForAlbum({
    required int albumId,
  }) async {
    try {
      Response response = await APIRequester.instance.dio
          .get('https://jsonplaceholder.typicode.com/albums/$albumId/photos');
      return Photo.listFromMap(response.data);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
