import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  SecureStorageService() {
    _secureStorage = const FlutterSecureStorage(
      aOptions: _androidOptions,
      // if needed, specify IOS options
    );
  }
  late final FlutterSecureStorage _secureStorage;

  static const AndroidOptions _androidOptions = AndroidOptions(
    encryptedSharedPreferences: true,
  );

  Future<Map<String, String>> getAllSeeds() {
    return _secureStorage.readAll();
  }

  Future<void> addNewSeed(String base32Seed) {
    return _secureStorage.write(key: base32Seed, value: base32Seed);
  }

  Future<String> getSeed(String base32Seed) async {
    return await _secureStorage.read(key: base32Seed) ?? '';
  }

  Future<void> removeSeed(String base32Seed) {
    return _secureStorage.delete(key: base32Seed);
  }
}
