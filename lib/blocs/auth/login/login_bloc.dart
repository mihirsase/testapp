import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/blocs/auth/login/login_event.dart';
import 'package:testapp/blocs/auth/login/login_state.dart';
import 'package:testapp/models/user/user.dart';
import 'package:testapp/models/user/user_repo.dart';
import 'package:testapp/services/storage.dart';
import 'package:testapp/services/wayfinder.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginLoaded());

  @override
  Stream<LoginState> mapEventToState(final LoginEvent event,) async* {
    if (event is PerformLogin) {
      yield LoginLoading();
      final User? _user = await UserRepo.instance.authenticateUser(
          email: event.email, password: event.password);
      if (_user != null) {
        Storage.instance.userID = _user.id;
        Wayfinder.instance.dashboard();
      }
      yield LoginLoaded();
    }
  }
}
