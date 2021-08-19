import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/blocs/dashboard/album/album_bloc.dart';
import 'package:testapp/blocs/dashboard/album/album_event.dart';
import 'package:testapp/blocs/dashboard/dashboard_bloc.dart';
import 'package:testapp/blocs/dashboard/dashboard_event.dart';
import 'package:testapp/blocs/dashboard/dashboard_state.dart';
import 'package:testapp/blocs/dashboard/home/home_bloc.dart';
import 'package:testapp/blocs/dashboard/home/home_event.dart';
import 'package:testapp/blocs/dashboard/profile/profile_bloc.dart';
import 'package:testapp/blocs/dashboard/profile/profile_event.dart';
import 'package:testapp/blocs/dashboard/todo/todo_bloc.dart';
import 'package:testapp/blocs/dashboard/todo/todo_event.dart';
import 'package:testapp/components/atoms/loading_atom.dart';
import 'package:testapp/components/atoms/refresh_atom.dart';
import 'package:testapp/screens/dashboard/album/album_screen.dart';
import 'package:testapp/screens/dashboard/dashboard_tab.dart';
import 'package:testapp/screens/dashboard/home/home_screen.dart';
import 'package:testapp/screens/dashboard/profile/profile_screen.dart';
import 'package:testapp/screens/dashboard/todo/todo_screen.dart';
import 'package:testapp/services/pallete.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late DashboardBloc _dashboardBloc;
  HomeBloc? _homeBloc;
  AlbumBloc? _albumBloc;
  TodoBloc? _todoBloc;
  ProfileBloc? _profileBloc;

  DashboardTab _dashboardTab = DashboardTabExtension.origin;

  @override
  void initState() {
    _dashboardBloc = DashboardBloc();
    _dashboardBloc.add(LoadDashboard());

    _dashboardBloc.stream.listen((final DashboardState state) {
      if (state is DashboardLoaded) {
        _homeBloc ??= HomeBloc();
        _homeBloc!.add(LoadHome());

        _albumBloc ??= AlbumBloc();
        _albumBloc!.add(LoadAlbum());

        _todoBloc ??= TodoBloc();
        _todoBloc!.add(LoadTodo());

        _profileBloc ??= ProfileBloc();
        _profileBloc!.add(LoadProfile());
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DashboardBloc>(
          create: (final BuildContext _) {
            return _dashboardBloc;
          },
        ),
        BlocProvider<HomeBloc>(
          create: (final BuildContext _) {
            return _homeBloc!;
          },
        ),
        BlocProvider<AlbumBloc>(
          create: (final BuildContext _) {
            return _albumBloc!;
          },
        ),
        BlocProvider<TodoBloc>(
          create: (final BuildContext _) {
            return _todoBloc!;
          },
        ),
        BlocProvider<ProfileBloc>(
          create: (final BuildContext _) {
            return _profileBloc!;
          },
        ),
      ],
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (final BuildContext _, DashboardState state) {
          return SafeArea(
            child: Scaffold(
              body: _body(state),
              bottomNavigationBar: _bottomNavigationBar(state),
            ),
          );
        },
      ),
    );
  }


  Widget? _bottomNavigationBar(final DashboardState state) {
    if (state is DashboardLoaded) {
      return BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Pallete.white,
        unselectedItemColor: Pallete.white.withOpacity(0.5),
        items: DashboardTab.values.map<BottomNavigationBarItem>(
          (final DashboardTab dashboardTab) {
            return BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(
                  bottom: 8,
                  top: 4,
                ),
                child: dashboardTab.inactiveIcon,
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(
                  bottom: 8,
                  top: 4,
                ),
                child: dashboardTab.icon,
              ),
              label: dashboardTab.title,
            );
          },
        ).toList(),
        onTap: (final int index) {
          setState(() {
            _dashboardTab = DashboardTab.values[index];
          });
        },
        backgroundColor: Pallete.bottomNav,
        currentIndex: DashboardTab.values.indexOf(_dashboardTab),
        type: BottomNavigationBarType.fixed,
      );
    } else {
      return null;
    }
  }

  Widget _body(DashboardState state) {
    if (state is DashboardLoaded) {
      switch (_dashboardTab) {
        case DashboardTab.home:
          return HomeScreen();
        case DashboardTab.album:
          return AlbumScreen();
        case DashboardTab.todo:
          return TodoScreen();
        case DashboardTab.profile:
          return ProfileScreen();
      }
    }
    return RefreshAtom(
      onRefresh: () async {
        _dashboardBloc.add(LoadDashboard());
      },
      child: LoadingAtom(),
    );
  }
}
