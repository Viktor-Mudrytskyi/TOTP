import 'package:flutter/foundation.dart';
import 'package:totp_authenticator/core/core.dart';

class CodesProvider extends ChangeNotifier {
  CodesProvider({required SecureStorageService secureStorageService}) : _secureStorageService = secureStorageService;

  final SecureStorageService _secureStorageService;

  List<SeedData> _seeds = [];
  bool _isinitialLoad = true;

  List<SeedData> get seeds => _seeds;
  bool get isInitialLoad => _isinitialLoad;

  Future<void> init() async {
    _seeds = await _secureStorageService.getAllSeeds();
    _isinitialLoad = false;
    notifyListeners();
  }

  Future<void> addNewSeed({required SeedData seedData}) async {
    _seeds.add(seedData);
    notifyListeners();
    await _secureStorageService.addNewSeed(seedData: seedData);
  }

  Future<void> deleteSeed({required SeedData seedData}) async {
    _seeds.remove(seedData);
    notifyListeners();
    await _secureStorageService.removeSeed(seedData.base32Seed);
  }
}
