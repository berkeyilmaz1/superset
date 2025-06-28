import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:superset/product/initialize/app_locales.dart';

final class MainLocalization extends EasyLocalization {
  MainLocalization({required super.child, super.key})
    : super(
        path: localizationPath,
        useOnlyLangCode: true,
        supportedLocales: appSupportedLocales,
        fallbackLocale: AppLocales.en.locale,
      );

  static const String localizationPath = 'assets/translations';

  static List<Locale> appSupportedLocales = AppLocales.values
      .map(
        (e) => e.locale,
      )
      .toList();
}
