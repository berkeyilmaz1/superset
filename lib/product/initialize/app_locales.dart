import 'package:flutter/material.dart';

enum AppLocales {
  en(Locale('en'));

  final Locale locale;
  const AppLocales(this.locale);
}
