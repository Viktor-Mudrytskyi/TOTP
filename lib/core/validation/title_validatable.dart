import 'package:totp_authenticator/core/core.dart';

class TitleValidatable extends Validatable<String, TitleFailure> {
  TitleValidatable(super.value);

  @override
  TitleFailure? validate() {
    if (value.isEmpty) {
      return TitleEmptyFailure();
    }
    if (value.length > 20) {
      return TitleTooLongFailure();
    }
    return null;
  }
}
