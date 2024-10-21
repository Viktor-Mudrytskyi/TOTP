import 'package:base32/base32.dart';
import 'package:totp_authenticator/core/core.dart';

class SeedValidatable extends Validatable<String, SeedFailure> {
  SeedValidatable(super.value);

  static final _base32Pattern = RegExp(r'^[A-Z2-7]+=*$');

  @override
  SeedFailure? validate() {
    if (value.isEmpty) {
      return SeedEmptyFailure();
    }

    if (!_base32Pattern.hasMatch(value)) {
      return SeedInvalidFailure();
    }

    if (value.length % 8 != 0) {
      return SeedLengthFailure();
    }

    if (value.length == 8) {
      return SeedTooShortFailure();
    }

    if (!_validateBase32Key(value)) {
      return SeedInvalidFailure();
    }

    return null;
  }

  bool _validateBase32Key(String key) {
    try {
      base32.decode(key);
    } catch (e) {
      return false;
    }
    return true;
  }
}
