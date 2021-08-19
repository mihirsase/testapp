import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/blocs/dashboard/home/comments/comments_event.dart';
import 'package:testapp/blocs/dashboard/home/comments/comments_state.dart';
import 'package:testapp/models/post/comment/comment.dart';
import 'package:testapp/models/post/post.dart';
import 'package:testapp/models/post/post_repo.dart';
import 'package:testapp/services/notifier.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final Post post;

  CommentsBloc({
    required this.post,
  }) : super(CommentsLoading());
  List<Comment> commentList = [];

  @override
  Stream<CommentsState> mapEventToState(
    final CommentsEvent event,
  ) async* {
    if (event is LoadComments) {
      yield CommentsLoading();

      if (post.id != null) {
        final List<Comment>? _response = await PostRepo.instance.getCommentsFromPost(
          postId: post.id!,
        );
        if (_response != null) {
          commentList = _response;
        }
      } else {
        Notifier.instance.alert(
          title: 'Not able to load comments',
          notifType: NotifType.negative,
        );
      }
      yield CommentsLoaded();
    }
  }
}
