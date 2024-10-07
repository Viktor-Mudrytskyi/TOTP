import 'package:totp_authenticator/core/core.dart';

class SeedValidatable extends Validatable<String, SeedFailure> {
  SeedValidatable(super.value);

  @override
  SeedFailure? validate() {
    if (value.isEmpty) {
      return SeedEmptyFailure();
    }
    if (!_isBase32(value)) {
      return SeedInvalidFailure();
    }
    return null;
  }

  bool _isBase32(String input) {
    // Correct RegExp for Base32 string (A-Z, 2-7, and optional '=' padding at the end)
    final RegExp regExp = RegExp(r'^[A-Z2-7]+=*$');

    // Length should be a multiple of 8, but we should also allow shorter valid base32 strings with padding
    if (input.isNotEmpty &&
        (input.length % 8 == 0 || input.endsWith('=') && input.length % 8 != 1) &&
        regExp.hasMatch(input)) {
      return true;
    } else {
      return false;
    }
  }
}
