import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/blocs/dashboard/home/home_event.dart';
import 'package:testapp/blocs/dashboard/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoading());

  @override
  Stream<HomeState> mapEventToState(
      final HomeEvent event,
      ) async* {
    if (event is LoadHome) {
      yield HomeLoading();


      yield HomeLoaded();
    }
  }
}
