abstract class SettingsRepository {
  Future<bool> getBool(String key, {bool defaultValue = false});
  Future<void> setBool(String key, bool value);

  Future<String?> getString(String key);
  Future<void> setString(String key, String value);

  Future<int> getInt(String key, {int defaultValue = 0});
  Future<void> setInt(String key, int value);

  Future<double> getDouble(String key, {double defaultValue = 0.0});
  Future<void> setDouble(String key, double value);

  Future<List<String>> getStringList(String key);
  Future<void> setStringList(String key, List<String> value);
}