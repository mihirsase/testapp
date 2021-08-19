import 'package:dio/dio.dart';
import 'package:testapp/models/album/album.dart';
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
}