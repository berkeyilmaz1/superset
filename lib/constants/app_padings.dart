import 'package:flutter/widgets.dart';

final class AppPadings extends EdgeInsets {
  const AppPadings.normal() : super.all(16);

  const AppPadings.medium() : super.all(8);

  const AppPadings.small() : super.all(4);

  const AppPadings.large() : super.all(24);

  const AppPadings.calendar() : super.symmetric(horizontal: 16, vertical: 8);
}
