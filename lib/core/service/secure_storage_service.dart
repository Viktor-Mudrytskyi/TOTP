import 'package:flutter/foundation.dart';
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

  Future<List<SeedData>> getAllSeeds() async {
    final results = await _secureStorage.readAll();

    final list = <SeedData>[];

    results.forEach((key, value) {
      list.add(SeedData(base32Seed: key, title: value));
    });
    return list;
  }

  Future<void> addNewSeed({
    required SeedData seedData,
  }) {
    return _secureStorage.write(key: seedData.base32Seed, value: seedData.title);
  }

  Future<SeedData> getSeed(String base32Seed) async {
    final title = await _secureStorage.read(key: base32Seed) ?? '';
    return SeedData(base32Seed: base32Seed, title: title);
  }

  Future<void> removeSeed(String base32Seed) {
    return _secureStorage.delete(key: base32Seed);
  }
}

@immutable
class SeedData {
  const SeedData({required this.base32Seed, required this.title});
  final String base32Seed;
  final String title;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SeedData && other.base32Seed == base32Seed && other.title == title;
  }

  @override
  int get hashCode => base32Seed.hashCode ^ title.hashCode;
}
