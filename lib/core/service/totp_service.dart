import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:totp_authenticator/core/core.dart';

class TotpService {
  const TotpService({required TotpHelper totpHelper}) : _totpHelper = totpHelper;

  final TotpHelper _totpHelper;

  static const int _secondsInterval = 30;

  int get timeStep {
    return DateTime.now().millisecondsSinceEpoch ~/ _secondsInterval;
  }

  String calculateSha256Hmac(String base32Seed) {
    final Uint8List secretBytes = _totpHelper.base32StringToBytes(base32Seed);
    final timeStepBytes = ByteData(8)..setInt64(0, timeStep);

    final Hmac hmac = Hmac(sha256, secretBytes);
    final List<int> hmacResult = hmac.convert(timeStepBytes.buffer.asUint8List()).bytes;

    return hmacResult.toString();
  }
}
