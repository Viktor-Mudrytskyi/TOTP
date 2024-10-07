class CodeModel {
  const CodeModel({
    required this.title,
    required this.code,
    required this.refreshRate,
    required this.initialFractionValue,
    required this.base32Seed,
  });

  final String title;
  final String code;
  final String base32Seed;
  final Duration refreshRate;

  /// The starting point for the animation.
  final double initialFractionValue;
}
