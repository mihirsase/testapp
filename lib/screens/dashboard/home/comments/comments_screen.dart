import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/blocs/dashboard/home/comments/comments_bloc.dart';
import 'package:testapp/blocs/dashboard/home/comments/comments_event.dart';
import 'package:testapp/blocs/dashboard/home/comments/comments_state.dart';
import 'package:testapp/components/atoms/loading_atom.dart';
import 'package:testapp/components/atoms/margin_atom.dart';
import 'package:testapp/components/atoms/refresh_atom.dart';
import 'package:testapp/models/post/comment/comment.dart';
import 'package:testapp/models/post/post.dart';
import 'package:testapp/services/pallete.dart';

class CommentsScreen extends StatefulWidget {
  final Post post;

  const CommentsScreen({
    required this.post,
  });

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  late CommentsBloc _commentsBloc;

  @override
  void initState() {
    _commentsBloc = CommentsBloc(
      post: widget.post,
    );
    _commentsBloc.add(LoadComments());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CommentsBloc>(
      create: (final BuildContext _) {
        return _commentsBloc;
      },
      child: BlocBuilder<CommentsBloc, CommentsState>(
        builder: (
          final BuildContext _,
          final CommentsState state,
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
        'View Comments',
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _body(final CommentsState state) {
    if (state is CommentsLoading) {
      return Center(
        child: LoadingAtom(),
      );
    }
    return RefreshAtom(
      onRefresh: () async {
        _commentsBloc.add(LoadComments());
      },
      child: ListView(
        children: [
          ..._commentsBloc.commentList
              .map((final Comment comment) => _commentTile(comment))
              .toList(),
        ],
      ),
    );
  }

  Widget _commentTile(final Comment comment) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: MarginAtom.padding(context)),
        title: Text(
          comment.name ?? '',
          style: TextStyle(
            color: Pallete.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                comment.email ?? '',
                style: TextStyle(
                  color: Pallete.secondaryText,
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              comment.body?.replaceAll('\n', '') ?? '',
              style: TextStyle(color: Pallete.greyLight),
            ),
          ],
        ),
      ),
    );
  }
}
