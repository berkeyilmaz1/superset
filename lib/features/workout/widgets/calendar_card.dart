import 'package:flutter/material.dart';
import 'package:superset/core/constants/app_padings.dart';
import 'package:superset/core/constants/border_radius_general.dart';

final class CalendarCard extends StatelessWidget {
  const CalendarCard({
    required this.isSelected,
    required this.day,
    required this.weekday,
    required this.onTap,
    super.key,
  });

  final bool isSelected;
  final String day;
  final String weekday;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: isSelected ? 4 : 1,
        color: isSelected ? Colors.blue.shade600 : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadiusGeneral.allVeryLow(),
          side: BorderSide(
            color: Colors.blue.shade200,
          ),
        ),
        child: Padding(
          padding: const AppPaddings.calendar(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 4,
            children: [
              Text(
                day,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : Colors.blue.shade800,
                ),
              ),

              Text(
                weekday,
                style: TextStyle(
                  fontSize: 14,
                  color: isSelected ? Colors.white : Colors.blue.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
