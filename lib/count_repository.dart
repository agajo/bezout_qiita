import 'package:shared_preferences/shared_preferences.dart';

class CountRepository {
  CountRepository() {
    SharedPreferences.getInstance().then((value) {
      _sharedPrefs = value;
    });
  }
  static const clearedCountKey = 'cleared_count';
  SharedPreferences _sharedPrefs;
  int load() => _sharedPrefs.getInt(clearedCountKey);
  void save(int value) {
    _sharedPrefs.setInt(clearedCountKey, value);
  }
}
