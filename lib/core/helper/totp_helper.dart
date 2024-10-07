import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:base32/base32.dart';

mixin class TotpHelper {
  Uint8List generate160Bits([int bytesLength = 20]) {
    final Random random = Random();
    final List<int> bytes = List.generate(bytesLength, (_) => random.nextInt(256));
    return Uint8List.fromList(bytes);
  }

  String base32FromBytes(Uint8List bytes) {
    return base32.encode(bytes);
  }

  String base32FromString(String string) {
    return base32.encodeString(string);
  }

  String base32DecodeString(String base32String) {
    return base32.decodeAsString(base32String);
  }

  Uint8List base32StringToBytes(String string) {
    return utf8.encode(string);
  }

  bool isNumericString(String str) {
    final pattern = RegExp(r'^\d+$');
    return pattern.hasMatch(str);
  }
}
