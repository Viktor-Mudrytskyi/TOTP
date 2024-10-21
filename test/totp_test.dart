import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:totp_authenticator/core/core.dart';

void main() {
  late final TotpService totpService;
  setUpAll(() async {
    await initDI();
    totpService = getIt();
  });

  test('Base32 encoding, decoding', () {
    final bytes = totpService.generate160Bits();
    expect(bytes.length, 20);

    final encoded = totpService.base32FromBytes(bytes);
    debugPrint('encoded: $encoded');
    final decoded = totpService.base32DecodeString(encoded);
    debugPrint('decoded: $decoded');
    final encodeAgain = totpService.base32FromString(decoded);
    debugPrint('encodeAgain: $encodeAgain');
    final decodeAgain = totpService.base32DecodeString(encodeAgain);
    debugPrint('decodeAgain: $decodeAgain');

    final encodedFirstBytes = totpService.base32StringToBytes(encoded);
    debugPrint('encodedFirstBytes: $encodedFirstBytes');

    final encodedSecondBytes = totpService.base32StringToBytes(encodeAgain);
    debugPrint('encodedSecondBytes: $encodedSecondBytes');

    expect(encodedFirstBytes, encodedSecondBytes);
    expect(encoded, encodeAgain);
    expect(decoded, decodeAgain);
  });

  test('calculateSha256Hmac', () {
    final bytes = totpService.generate160Bits();
    final encoded = totpService.base32FromBytes(bytes);

    final hmac = totpService.calculateSha1Hmac(encoded);
    debugPrint('hmac: $hmac');

    // Length of sha256 hash
    expect(hmac.length, 32);
  });

  test('getTotp', () {
    final bytes = totpService.generate160Bits();
    final base32Seed = totpService.base32FromBytes(bytes);

    final totp = totpService.getTotp(base32Seed);
    expect(totp.length, 6);
    expect(totpService.isNumericString(totp), true);
    debugPrint('totp: $totp');
  });
}
