import 'dart:ui';

import 'package:flutter/material.dart';

extension ContextUtils on BuildContext {
  bool get isLtr => Directionality.of(this) == TextDirection.ltr;
  void removeFocus() {
    final currentScope = FocusScope.of(this);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  ThemeData get theme => Theme.of(this);

  RenderBox? get renderBox {
    final box = findRenderObject();

    if (box == null || box is! RenderBox) {
      return null;
    }
    return box;
  }

  EdgeInsets get padding => MediaQuery.paddingOf(this);

  FlutterView get view => View.of(this);
}

extension NullOrEmptyString on String? {
  bool get isNullOrEmpty => (this ?? '').isEmpty;

  bool get isNotNullOrEmpty => (this ?? '').isNotEmpty;

  bool get isNullOrEmptyTrim => (this ?? '').trim().isEmpty;

  bool get isNotNullOrEmptyTrim => (this ?? '').trim().isNotEmpty;
}

extension StringExtension on String {
  String capitalize() => '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
}

extension StringCharacters on String? {
  String? get firstCharacterCapOrNull => isNullOrEmptyTrim ? null : this!.characters.firstOrNull;
}

extension NullOrEmptyList on List<dynamic>? {
  bool get isNullOrEmpty => (this ?? []).isEmpty;
  bool get isNotNullOrEmpty => (this ?? []).isNotEmpty;
}

extension ListUtils<T> on List<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
