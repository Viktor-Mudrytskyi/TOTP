import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:totp_authenticator/core/core.dart';
import 'package:totp_authenticator/view/view.dart';

class SingleCodeProvider extends ChangeNotifier {
  SingleCodeProvider({required TotpService totpService}) : _totpService = totpService;

  final TotpService _totpService;

  CodeModel get codeModel => _codeModel;
  double get clockFraction {
    return _secondsSinceEpoch % 30 / 30;
  }

  CodeModel _codeModel = CodeModel.empty();
  int _secondsSinceEpoch = 0;

  StreamSubscription<int>? _secondsSubscription;

  void init(SeedData seedData) {
    final code = _totpService.getTotp(seedData.base32Seed);
    _codeModel = CodeModel.fromSeedDataAndCode(seedData: seedData, totpCode: code);
    _secondsSubscription = _totpService.secondsSinceEpochStream.listen(_updateClockAndCheckCode);
    _secondsSinceEpoch = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  }

  void _updateClockAndCheckCode(int seconds) {
    _secondsSinceEpoch = seconds;
    final shouldUpdateCode = _secondsSinceEpoch % 30 == 0;
    if (shouldUpdateCode) {
      final code = _totpService.getTotp(_codeModel.base32Seed);
      _codeModel = _codeModel.copyWith(code: code);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _secondsSubscription?.cancel();
    super.dispose();
  }
}
