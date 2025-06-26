import 'package:flutter/material.dart';
import 'package:superset/core/constants/app_padings.dart';
import 'package:superset/core/constants/border_radius_general.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.onPressed,
    super.key,
  });
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const AppPadings.buttonPadding(),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusGeneral.allSmall(),
        ),
      ),
      child: Text(
        'Add Exercise',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.blue.shade600,
        ),
      ),
    );
  }
}
