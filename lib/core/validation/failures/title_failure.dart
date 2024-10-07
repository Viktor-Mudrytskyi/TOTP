import 'package:totp_authenticator/core/validation/failures/failures.dart';

sealed class TitleFailure extends Failure {
  const TitleFailure({required super.message});
}

final class TitleEmptyFailure extends TitleFailure {
  TitleEmptyFailure() : super(message: 'Title cannot be empty');
}

final class TitleTooLongFailure extends TitleFailure {
  TitleTooLongFailure() : super(message: 'Title is too long');
}
