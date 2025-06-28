import 'package:flutter/widgets.dart';

final class AppPaddings extends EdgeInsets {
  /// Normal padding is set to 16 pixels on all sides.
  const AppPaddings.normal() : super.all(16);

  /// Medium padding is set to 8 pixels on all sides.
  const AppPaddings.medium() : super.all(8);

  /// Small padding is set to 4 pixels on all sides.
  const AppPaddings.small() : super.all(4);

  /// Large padding is set to 24 pixels on all sides.
  const AppPaddings.large() : super.all(24);

  /// Pading for the calendar widget, set to 16 pixels horizontally and 8 pixels vertically.
  const AppPaddings.calendar() : super.symmetric(horizontal: 16, vertical: 8);

  /// Padding for the button, set to 32 pixels horizontally and 16 pixels vertically.
  const AppPaddings.buttonPadding()
    : super.symmetric(horizontal: 32, vertical: 16);

  const AppPaddings.chip() : super.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  );
   

      

}
