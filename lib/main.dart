import 'package:flutter/material.dart';
import 'package:testapp/components/atoms/loading_atom.dart';
import 'package:testapp/screens/initial_screen.dart';
import 'package:testapp/services/keyboard.dart';
import 'package:testapp/services/pallete.dart';
import 'package:testapp/services/storage.dart';

void main() {
  runApp(TestApp());
}

class TestApp extends StatefulWidget {
  const TestApp({Key? key}) : super(key: key);

  @override
  _TestAppState createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  late Future _loadStorageFuture;

  @override
  void initState() {
    _loadStorageFuture = Storage.instance.load();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadStorageFuture,
      builder: (final BuildContext _, final AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.connectionState == ConnectionState.active) {
          return LoadingAtom();
        } else {
          return GestureDetector(
            onTap: () {
              Keyboard.instance.dismiss();
            },
            child: MaterialApp(
              navigatorKey: _navigatorKey,
              title: 'Test App',
              themeMode: ThemeMode.dark,
              theme: ThemeData(
                  canvasColor: Pallete.black,
                  appBarTheme: AppBarTheme(
                    color: Pallete.black,
                    centerTitle: true,
                  )),
              debugShowCheckedModeBanner: false,
              home: InitialScreen(
                navigatorKey: _navigatorKey,
              ),
            ),
          );
        }
      },
    );
  }
}
