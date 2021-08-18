import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/blocs/auth/login/login_bloc.dart';
import 'package:testapp/blocs/auth/login/login_event.dart';
import 'package:testapp/blocs/auth/login/login_state.dart';
import 'package:testapp/components/atoms/button_atom.dart';
import 'package:testapp/components/atoms/form_atom.dart';
import 'package:testapp/components/atoms/loading_atom.dart';
import 'package:testapp/components/atoms/margin_atom.dart';
import 'package:testapp/components/molecules/text_field_molecule.dart';
import 'package:testapp/services/keyboard.dart';
import 'package:testapp/services/pallete.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late LoginBloc _loginBloc;
  String? _email;
  String? _password;

  @override
  void initState() {
    _loginBloc = LoginBloc();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (final BuildContext _) {
        return _loginBloc;
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (
          final BuildContext _,
          final LoginState state,
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
      title: Text(
        'Log in'.toUpperCase(),
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _body(final LoginState state) {
    if (state is LoginLoading) {
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
              labelText: 'Email ID',
              autocorrect: false,
              hintText: 'example@gmail.com',
              onEditingComplete: () {
                Keyboard.instance.next();
              },
              onChanged: (final String value) {
                _email = value;
              },
              validator: (final String? value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a valid email address";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 22,
            ),
            TextFieldMolecule(
              labelText: 'Password',
              isPassword: true,
              onEditingComplete: () {
                Keyboard.instance.dismiss();
              },
              onChanged: (final String value) {
                _password = value;
              },
              validator: (final String? value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a valid password";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 44,
            ),
            ButtonAtom(
              title: 'Continue',
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

      _loginBloc.add(
        PerformLogin(
          email: _email!,
          password: _password!,
        ),
      );
    }
  }
}
