import 'package:shared_preferences/shared_preferences.dart';

class CountRepository {
  CountRepository() {
    SharedPreferences.getInstance().then((value) {
      _sharedPrefs = value;
    });
  }
  static const clearedCountKey = 'cleared_count';
  SharedPreferences _sharedPrefs;
  Future<int> load() async {
    if (_sharedPrefs != null) {
      return _sharedPrefs.getInt(clearedCountKey) ?? 0;
    } else {
      return SharedPreferences.getInstance()
          .then((value) => value.getInt(clearedCountKey) ?? 0);
    }
  }

  void save(int value) {
    _sharedPrefs.setInt(clearedCountKey, value);
  }
}
