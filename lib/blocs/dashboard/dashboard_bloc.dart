import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/blocs/dashboard/dashboard_event.dart';
import 'package:testapp/blocs/dashboard/dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardLoading());

  @override
  Stream<DashboardState> mapEventToState(
      final DashboardEvent event,
      ) async* {
    if (event is LoadDashboard) {
      yield DashboardLoading();


      yield DashboardLoaded();
    }
  }
}
