import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
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

extension ContextPickers on BuildContext {
  Future<DateTime?> pickDate({
    DateTime? initialPicked,
    DateTime? minimumDate,
    DateTime? maximumDate,
  }) async {
    final now = DateTime.now();
    final min = minimumDate ?? DateTime(1900);
    final max = maximumDate ?? DateTime(2100, 2, 28);
    final initial = initialPicked ?? DateTime.now();

    final minRounded = DateTime(min.year, min.month, min.day);
    final maxRounded = DateTime(max.year, max.month, max.day);
    final initialRounded = DateTime(initial.year, initial.month, initial.day);
    final nowRounded = DateTime(now.year, now.month, now.day);

    if (Platform.isAndroid) {
      return showDatePicker(
        context: this,
        initialDate: initialRounded,
        firstDate: minRounded,
        lastDate: maxRounded,
        currentDate: nowRounded,
        initialEntryMode: DatePickerEntryMode.calendarOnly,
      );
    } else if (Platform.isIOS) {
      DateTime? picked;
      await showCupertinoModalPopup<DateTime?>(
        context: this,
        builder: (context) => Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: SafeArea(
            top: false,
            child: CupertinoDatePicker(
              initialDateTime: initialRounded,
              minimumDate: minRounded,
              maximumDate: maxRounded,
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (newDate) {
                picked = newDate;
              },
            ),
          ),
        ),
      );
      return picked;
    }
    return null;
  }
}
