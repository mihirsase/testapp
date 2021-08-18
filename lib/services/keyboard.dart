import 'package:flutter/material.dart';

class Keyboard {
  static final Keyboard  instance = Keyboard._();

  Keyboard._();

  void dismiss() {
    WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus();
  }

  void next() {
    Widget  widget;

    do {
      WidgetsBinding.instance!.focusManager.primaryFocus!.nextFocus();

      widget = FocusScope.of(
        WidgetsBinding.instance!.focusManager.primaryFocus!.context!,
      ).focusedChild!.context!.widget;
    } while (widget is! EditableText );
  }
}