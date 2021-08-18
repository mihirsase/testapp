import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/blocs/dashboard/profile/profile_event.dart';
import 'package:testapp/blocs/dashboard/profile/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileLoading());

  @override
  Stream<ProfileState> mapEventToState(
      final ProfileEvent event,
      ) async* {
    if (event is LoadProfile) {
      yield ProfileLoading();


      yield ProfileLoaded();
    }
  }
}
