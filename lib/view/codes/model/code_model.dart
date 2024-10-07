import 'package:totp_authenticator/core/core.dart';

class CodeModel {
  const CodeModel({
    required this.title,
    required this.code,
    required this.refreshRate,
    required this.initialFractionValue,
    required this.base32Seed,
  });

  factory CodeModel.empty() {
    return const CodeModel(
      title: '',
      code: '',
      refreshRate: Duration(seconds: 30),
      initialFractionValue: 0.1,
      base32Seed: '',
    );
  }

  factory CodeModel.fromSeedDataAndCode({required SeedData seedData, required String totpCode}) {
    return CodeModel(
      title: seedData.title,
      code: totpCode,
      refreshRate: const Duration(seconds: 30),
      initialFractionValue: 0.1,
      base32Seed: seedData.base32Seed,
    );
  }

  final String title;
  final String code;
  final String base32Seed;
  final Duration refreshRate;

  /// The starting point for the animation.
  final double initialFractionValue;

  CodeModel copyWith({
    String? title,
    String? code,
    String? base32Seed,
    Duration? refreshRate,
    double? initialFractionValue,
  }) {
    return CodeModel(
      title: title ?? this.title,
      code: code ?? this.code,
      base32Seed: base32Seed ?? this.base32Seed,
      refreshRate: refreshRate ?? this.refreshRate,
      initialFractionValue: initialFractionValue ?? this.initialFractionValue,
    );
  }
}
