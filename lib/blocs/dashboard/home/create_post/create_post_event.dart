abstract class CreatePostEvent {}

class SubmitPost extends CreatePostEvent {
  final String title;
  final String post;

  SubmitPost({
    required final this.title,
    required final this.post,
  });
}