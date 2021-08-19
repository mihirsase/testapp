import 'package:dio/dio.dart';
import 'package:testapp/models/user/user.dart';
import 'package:testapp/services/api_requester.dart';
import 'package:testapp/services/db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:testapp/services/notifier.dart';
import 'package:testapp/services/storage.dart';

class UserRepo {
  static final UserRepo instance = UserRepo._();

  UserRepo._();

  Future<void> populateDummyData() async {
    final db = await DB.instance.database;
    int count = (await db.rawQuery('SELECT COUNT(*) FROM users;'))[0]["COUNT(*)"] as int;
    print(count);
    if (count == 0) {
      print('Added data in to the table');
      final Batch batch = db.batch();
      for (final User user in dummyUsers) {
        batch.insert(
          'users',
          user.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      batch.commit();
    } else {
      print('Table already populated');
    }
  }

  Future<User?> authenticateUser({required String email, required String password}) async {
    try {
      final db = await DB.instance.database;
      //final row = (await db.query('users', where: 'email = ?', whereArgs: [email]));
      final row = (await db.rawQuery("SELECT * FROM users WHERE email = '$email' COLLATE NOCASE"));
      if (row.length == 0) {
        Notifier.instance.alert(
          title: 'Email does not exist in our database',
          notifType: NotifType.negative,
        );
        return null;
      }
      final User _user = User.fromMap(row[0]);
      if (_user.username!.toLowerCase() == password.toLowerCase()) {
        return _user;
      }
      Notifier.instance.alert(
        title: 'Password is incorrect',
        notifType: NotifType.negative,
      );
      // Password is incorrect
      return null;
    } catch (e) {
      print(e);
      Notifier.instance.alert(
        title: 'Something went wrong',
        notifType: NotifType.negative,
      );
      return null;
    }
  }

  Future<User?> getUserDetails() async {
    try {
      Response response = await APIRequester.instance.dio
          .get('https://jsonplaceholder.typicode.com/users/${Storage.instance.userID}');
      return User.fromMap(response.data);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
