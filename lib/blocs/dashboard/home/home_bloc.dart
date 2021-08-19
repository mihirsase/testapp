import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/blocs/dashboard/home/home_event.dart';
import 'package:testapp/blocs/dashboard/home/home_state.dart';
import 'package:testapp/models/post/post.dart';
import 'package:testapp/models/post/post_repo.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoading());
  List<Post> postList = [];

  @override
  Stream<HomeState> mapEventToState(
    final HomeEvent event,
  ) async* {
    if (event is LoadHome) {
      yield HomeLoading();

      final List<Post>? _response = await PostRepo.instance.getPosts();
      if (_response != null) {
        postList = _response;
      }
      yield HomeLoaded();
    }
  }
}
