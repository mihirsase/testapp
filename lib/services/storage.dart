import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static final Storage instance = Storage._();

  Storage._();

  late SharedPreferences _sharedPreferences;

  Future<void> load() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  String? _getString({
    required final String key,
  }) {
    return _sharedPreferences.getString(key);
  }

  void _setString({
    required final String key,
    required final String? value,
  }) {
    if (value == null) {
      _sharedPreferences.remove(key);
    } else {
      _sharedPreferences.setString(key, value);
    }
  }
}
