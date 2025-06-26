import 'package:flutter/widgets.dart';

final class AppPadings extends EdgeInsets {
  /// Normal padding is set to 16 pixels on all sides.
  const AppPadings.normal() : super.all(16);

  /// Medium padding is set to 8 pixels on all sides.
  const AppPadings.medium() : super.all(8);

  /// Small padding is set to 4 pixels on all sides.
  const AppPadings.small() : super.all(4);

  /// Large padding is set to 24 pixels on all sides.
  const AppPadings.large() : super.all(24);

  /// Pading for the calendar widget, set to 16 pixels horizontally and 8 pixels vertically.
  const AppPadings.calendar() : super.symmetric(horizontal: 16, vertical: 8);
}
