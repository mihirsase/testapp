import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/blocs/dashboard/profile/profile_event.dart';
import 'package:testapp/blocs/dashboard/profile/profile_state.dart';
import 'package:testapp/models/user/user.dart';
import 'package:testapp/models/user/user_repo.dart';
import 'package:testapp/services/storage.dart';
import 'package:testapp/services/wayfinder.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileLoading());
  User user = User();

  @override
  Stream<ProfileState> mapEventToState(
    final ProfileEvent event,
  ) async* {
    if (event is LoadProfile) {
      yield ProfileLoading();

      final User? _response = await UserRepo.instance.getUserDetails();
      if (_response != null) {
        user = _response;
      }
      yield ProfileLoaded();
    }else if(event is Logout){
      Storage.instance.userID = null;
      Wayfinder.instance.loginScreen();
    }
  }
}
