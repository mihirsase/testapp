import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/blocs/auth/login/login_event.dart';
import 'package:testapp/blocs/auth/login/login_state.dart';
import 'package:testapp/services/wayfinder.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginLoaded());

  @override
  Stream<LoginState> mapEventToState(
      final LoginEvent event,
      ) async* {
    if (event is PerformLogin) {
      yield LoginLoading();
      Wayfinder.instance.dashboard();
      yield LoginLoaded();
    }
  }
}