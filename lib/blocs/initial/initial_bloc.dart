import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/blocs/initial/initial_event.dart';
import 'package:testapp/models/user/user_repo.dart';
import 'package:testapp/services/storage.dart';
import 'package:testapp/services/wayfinder.dart';

class InitialBloc extends Bloc<InitialEvent, void> {
  final GlobalKey<NavigatorState> navigatorKey;

  InitialBloc({
    required final this.navigatorKey,
  }) : super(null) {
    Wayfinder.instance.navigatorKey = navigatorKey;
  }

  @override
  Stream<void> mapEventToState(
    final InitialEvent event,
  ) async* {
    if (event is LoadApp) {
      await SystemChrome.setPreferredOrientations(
        <DeviceOrientation>[
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ],
      );
      await UserRepo.instance.populateDummyData();

      await Future.delayed(Duration(seconds: 2));
      if(Storage.instance.userID == null) {
        Wayfinder.instance.loginScreen();
      }else{
        Wayfinder.instance.dashboard();
      }
    }
  }
}
