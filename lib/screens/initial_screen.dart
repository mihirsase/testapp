import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testapp/blocs/initial/initial_bloc.dart';
import 'package:testapp/blocs/initial/initial_event.dart';
import 'package:testapp/components/atoms/empty_atom.dart';
import 'package:testapp/components/atoms/refresh_atom.dart';

class InitialScreen extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  InitialScreen({
    required final this.navigatorKey,
  });

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  late InitialBloc _initialBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(final BuildContext _) {
    return BlocProvider<InitialBloc>(
      create: (final BuildContext _) {
        return _initialBloc = InitialBloc(
          navigatorKey: widget.navigatorKey,
        )..add(LoadApp());
      },
      child: BlocBuilder<InitialBloc, void>(
        builder: (final BuildContext _, final void state) {
          return _body();
        },
      ),
    );
  }

  Widget _body() {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: RefreshAtom(
          onRefresh: () async {
            _initialBloc.add(LoadApp());
          },
          child: EmptyAtom(
            child: Container(
              child: Center(
                child: SvgPicture.asset("lib/assets/app_icon.svg"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
