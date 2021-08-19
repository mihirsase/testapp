import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static final Storage instance = Storage._();

  Storage._();

  late SharedPreferences _sharedPreferences;

  Future<void> load() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  int? get userID {
    return _getInt(key: 'userId');
  }

  set userID(final int? userId) {
    return _setInt(key: 'userId', value: userId);
  }

  int? _getInt({
    required final String key,
  }) {
    return _sharedPreferences.getInt(key);
  }

  void _setInt({
    required final String key,
    required final int? value,
  }) {
    if (value == null) {
      _sharedPreferences.remove(key);
    } else {
      _sharedPreferences.setInt(key, value);
    }
  }
}
