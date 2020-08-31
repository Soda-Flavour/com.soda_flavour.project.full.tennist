import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageHelper {
  static final storage = new FlutterSecureStorage();

  static final StorageHelper _instance = StorageHelper._internal();
  factory StorageHelper() => _instance;

  StorageHelper._internal() {
    //초기화 코드
    print("StorageHelper loaded...");
  }

  static writeStorage(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  static deleteStorage(String key) async {
    await storage.delete(key: key);
  }

  static Future<String> readStorage(String key) async {
    String value = await storage.read(key: key);
    print('sotrage value: $value');
    return value;
  }
}
