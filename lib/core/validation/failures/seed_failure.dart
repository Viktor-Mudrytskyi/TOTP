import 'package:totp_authenticator/core/validation/failures/failures.dart';

sealed class SeedFailure extends Failure {
  const SeedFailure({required super.message});
}

final class SeedEmptyFailure extends SeedFailure {
  SeedEmptyFailure() : super(message: 'Seed cannot be empty');
}

final class SeedLengthFailure extends SeedFailure {
  SeedLengthFailure() : super(message: 'Seed length is not multiple of 8');
}

final class SeedTooShortFailure extends SeedFailure {
  SeedTooShortFailure() : super(message: 'Seed is too short');
}

final class SeedInvalidFailure extends SeedFailure {
  SeedInvalidFailure() : super(message: 'Seed is invalid base32 string');
}
