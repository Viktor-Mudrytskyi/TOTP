import 'package:totp_authenticator/core/core.dart';

class CodeModel {
  const CodeModel({
    required this.title,
    required this.code,
    required this.refreshRateSeconds,
    required this.base32Seed,
  });

  factory CodeModel.empty() {
    return const CodeModel(
      title: '',
      code: '',
      refreshRateSeconds: 30,
      base32Seed: '',
    );
  }

  factory CodeModel.fromSeedDataAndCode({required SeedData seedData, required String totpCode}) {
    return CodeModel(
      title: seedData.title,
      code: totpCode,
      refreshRateSeconds: 30,
      base32Seed: seedData.base32Seed,
    );
  }

  final String title;
  final String code;
  final String base32Seed;
  final int refreshRateSeconds;

  CodeModel copyWith({
    String? title,
    String? code,
    String? base32Seed,
    int? refreshRateSeconds,
    double? initialFractionValue,
  }) {
    return CodeModel(
      title: title ?? this.title,
      code: code ?? this.code,
      base32Seed: base32Seed ?? this.base32Seed,
      refreshRateSeconds: refreshRateSeconds ?? this.refreshRateSeconds,
    );
  }
}
