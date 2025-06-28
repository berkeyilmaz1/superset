import 'package:easy_localization/easy_localization.dart';

final class MainLocalization extends EasyLocalization {
  MainLocalization({required super.child, super.key})
    : super(
        path: localizationPath,
        useOnlyLangCode: true,
        supportedLocales: [],
      );

  static const String localizationPath = 'assets/translations/en.json';
}
