import 'package:flutter/foundation.dart';
import 'package:totp_authenticator/core/core.dart';
import 'package:totp_authenticator/view/view.dart';

class SingleCodeProvider extends ChangeNotifier {
  SingleCodeProvider({required TotpService totpService}) : _totpService = totpService;

  final TotpService _totpService;

  CodeModel get codeModel => _codeModel;

  CodeModel _codeModel = CodeModel.empty();

  void init(SeedData seedData) {
    final code = _totpService.getTotp(seedData.base32Seed);
    _codeModel = CodeModel.fromSeedDataAndCode(seedData: seedData, totpCode: code);
  }
}
