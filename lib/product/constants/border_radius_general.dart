import 'package:flutter/material.dart';

final class BorderRadiusGeneral extends BorderRadius {
  /// Radius is 24 [Radius.circular]
  const BorderRadiusGeneral.all() : super.all(const Radius.circular(24));

  /// Radius is 12 [Radius.circular]
  const BorderRadiusGeneral.allMedium() : super.all(const Radius.circular(12));

  /// Radius is 8 [Radius.circular]
  const BorderRadiusGeneral.allSmall() : super.all(const Radius.circular(8));

  /// Radius is 4 [Radius.circular]
  const BorderRadiusGeneral.allVeryLow() : super.all(const Radius.circular(4));

  const BorderRadiusGeneral.bottomSheet()
    : super.only(
        topLeft: const Radius.circular(16),
        topRight: const Radius.circular(16),
      );

  
}
