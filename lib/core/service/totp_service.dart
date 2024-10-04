import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:totp_authenticator/core/core.dart';

class TotpService {
  const TotpService({required TotpHelper totpHelper}) : _totpHelper = totpHelper;

  final TotpHelper _totpHelper;

  static const int _secondsInterval = 30;
  static const int _codeLength = 6;

  int get timeStep {
    return DateTime.now().millisecondsSinceEpoch ~/ 1000 ~/ _secondsInterval;
  }

  String getTotp(String base32Seed) {
    final hmacRes = calculateSha256Hmac(base32Seed);
    // Extract dynamic offset and truncated hash
    final offset = hmacRes[hmacRes.length - 1] & 0xF;
    final truncatedHash = ((hmacRes[offset] & 0x7F) << 24) |
        ((hmacRes[offset + 1] & 0xFF) << 16) |
        ((hmacRes[offset + 2] & 0xFF) << 8) |
        (hmacRes[offset + 3] & 0xFF);

    // Get the final [_codeLength]-digit code
    final code = truncatedHash % pow(10, _codeLength);

    // Convert to string and pad with leading zeros if necessary
    return code.toString().padLeft(_codeLength, '0');
  }

  List<int> calculateSha256Hmac(String base32Seed) {
    final Uint8List secretBytes = _totpHelper.base32StringToBytes(base32Seed);
    final timeStepBytes = ByteData(8)..setInt64(0, timeStep);

    // Initialize our hmac given sha256 and secret key, which is base32Seed
    final Hmac hmac = Hmac(sha256, secretBytes);

    // Get the hmac result from the time step, which verifies the time step
    final List<int> hmacResult = hmac.convert(timeStepBytes.buffer.asUint8List()).bytes;

    return hmacResult;
  }
}
