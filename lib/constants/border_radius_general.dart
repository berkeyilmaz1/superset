import 'package:flutter/material.dart';

final class BorderRadiusGeneral extends BorderRadius {
  /// Radius is 24 [Radius.circular]
  const BorderRadiusGeneral.all() : super.all(const Radius.circular(24));

  /// Radius is 12 [Radius.circular]
  const BorderRadiusGeneral.allLow() : super.all(const Radius.circular(12));

  /// Radius is 8 [Radius.circular]
  const BorderRadiusGeneral.allVeryLow() : super.all(const Radius.circular(8));
}
