import 'package:totp_authenticator/core/core.dart';

class CodeModel {
  const CodeModel({
    required this.title,
    required this.code,
    required this.base32Seed,
  });

  factory CodeModel.empty() {
    return const CodeModel(
      title: '',
      code: '',
      base32Seed: '',
    );
  }

  factory CodeModel.fromSeedDataAndCode({required SeedData seedData, required String totpCode}) {
    return CodeModel(
      title: seedData.title,
      code: totpCode,
      base32Seed: seedData.base32Seed,
    );
  }

  final String title;
  final String code;
  final String base32Seed;

  CodeModel copyWith({
    String? title,
    String? code,
    String? base32Seed,
  }) {
    return CodeModel(
      title: title ?? this.title,
      code: code ?? this.code,
      base32Seed: base32Seed ?? this.base32Seed,
    );
  }
}
