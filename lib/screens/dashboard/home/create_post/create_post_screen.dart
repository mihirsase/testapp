import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/blocs/dashboard/home/create_post/create_post_bloc.dart';
import 'package:testapp/blocs/dashboard/home/create_post/create_post_event.dart';
import 'package:testapp/blocs/dashboard/home/create_post/create_post_state.dart';
import 'package:testapp/components/atoms/button_atom.dart';
import 'package:testapp/components/atoms/form_atom.dart';
import 'package:testapp/components/atoms/loading_atom.dart';
import 'package:testapp/components/atoms/margin_atom.dart';
import 'package:testapp/components/molecules/text_field_molecule.dart';
import 'package:testapp/services/keyboard.dart';
import 'package:testapp/services/pallete.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late CreatePostBloc _createPostBloc;
  String? _title;
  String? _post;

  @override
  void initState() {
    _createPostBloc = CreatePostBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreatePostBloc>(
      create: (final BuildContext _) {
        return _createPostBloc;
      },
      child: BlocBuilder<CreatePostBloc, CreatePostState>(
        builder: (
          final BuildContext _,
          final CreatePostState state,
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
        'Create Post',
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _body(final CreatePostState state) {
    if (state is CreatePostLoading) {
      return Center(
        child: LoadingAtom(),
      );
    }
    return Form(
      key: _formKey,
      child: MarginAtom(
        child: FormAtom(
          children: [
            SizedBox(
              height: 12,
            ),
            TextFieldMolecule(
              labelText: 'Title',
              onEditingComplete: () {
                Keyboard.instance.next();
              },
              onChanged: (final String value) {
                _title = value;
              },
            ),
            SizedBox(
              height: 22,
            ),
            TextFieldMolecule(
              labelText: 'Post',
              maxLines: 3,
              onEditingComplete: () {
                Keyboard.instance.dismiss();
              },
              onChanged: (final String value) {
                _post = value;
              },
            ),
            SizedBox(
              height: 44,
            ),
            ButtonAtom(
              title: 'Submit Post',
              color: Pallete.green,
              textColor: Pallete.white,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      _createPostBloc.add(
        SubmitPost(
          title: _title!,
          post: _post!,
        ),
      );
    }
  }
}
