import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const String KEY_1 = "KEY_1";
const String KEY_2 = "KEY_2";
const String KEY_3 = "KEY_3";

class SecureStorage {
  late FlutterSecureStorage secureStorage;

  SecureStorage(FlutterSecureStorage preferences) {
    secureStorage = preferences;
  }

  Future<bool> hasData(String key) async {
    return await secureStorage.containsKey(key: key);
  }

  Future<void> setData(String key, String value) async {
    await secureStorage.write(key: key, value: value);
  }

  Future<String?> getData(String key) async {
    if (await secureStorage.containsKey(key: key)) {
      return await secureStorage.read(key: key);
    } else {
      return "";
    }
  }

  Future<void> clearData(String key) async {
    await secureStorage.delete(key: key);
  }
}
