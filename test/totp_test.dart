import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:totp_authenticator/core/core.dart';

void main() {
  late final TotpHelper totpHelper;
  late final TotpService totpService;
  setUpAll(() async {
    await initDI();
    totpHelper = getIt();
    totpService = getIt();
  });

  test('Base32 encoding, decoding', () {
    final bytes = totpHelper.generate160Bits();
    expect(bytes.length, 20);

    final encoded = totpHelper.base32FromBytes(bytes);
    debugPrint('encoded: $encoded');
    final decoded = totpHelper.base32DecodeString(encoded);
    debugPrint('decoded: $decoded');
    final encodeAgain = totpHelper.base32FromString(decoded);
    debugPrint('encodeAgain: $encodeAgain');
    final decodeAgain = totpHelper.base32DecodeString(encodeAgain);
    debugPrint('decodeAgain: $decodeAgain');

    final encodedFirstBytes = totpHelper.base32StringToBytes(encoded);
    debugPrint('encodedFirstBytes: $encodedFirstBytes');

    final encodedSecondBytes = totpHelper.base32StringToBytes(encodeAgain);
    debugPrint('encodedSecondBytes: $encodedSecondBytes');

    expect(encodedFirstBytes, encodedSecondBytes);
    expect(encoded, encodeAgain);
    expect(decoded, decodeAgain);
  });

  test('calculateSha256Hmac', () {
    final bytes = totpHelper.generate160Bits();
    final encoded = totpHelper.base32FromBytes(bytes);

    final hmac = totpService.calculateSha256Hmac(encoded);
    debugPrint('hmac: $hmac');

    // Length of sha256 hash
    expect(hmac.length, 32);
  });

  test('getTotp', () {
    final bytes = totpHelper.generate160Bits();
    final base32Seed = totpHelper.base32FromBytes(bytes);

    final totp = totpService.getTotp(base32Seed);
    expect(totp.length, 6);
    expect(totpHelper.isNumericString(totp), true);
    debugPrint('totp: $totp');
  });
}
