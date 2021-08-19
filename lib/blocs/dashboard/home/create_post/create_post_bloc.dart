import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/blocs/dashboard/home/create_post/create_post_event.dart';
import 'package:testapp/blocs/dashboard/home/create_post/create_post_state.dart';
import 'package:testapp/models/post/post.dart';
import 'package:testapp/models/post/post_repo.dart';
import 'package:testapp/services/notifier.dart';
import 'package:testapp/services/wayfinder.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  CreatePostBloc() : super(CreatePostLoaded());

  @override
  Stream<CreatePostState> mapEventToState(
    final CreatePostEvent event,
  ) async* {
    if (event is SubmitPost) {
      yield CreatePostLoading();
      final Post? post = await PostRepo.instance.createPost(title: event.title, post: event.post);
      if (post == null) {
        Notifier.instance.alert(
          title: 'Post creation failed!',
          notifType: NotifType.positive,
        );
      } else {
        Notifier.instance.alert(
          title: 'Post created successfully!',
          notifType: NotifType.positive,
        );
        Wayfinder.instance.pop();
      }
      yield CreatePostLoaded();
    }
  }
}
