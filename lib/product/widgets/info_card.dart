import 'package:flutter/material.dart';
import 'package:superset/product/constants/app_padings.dart';
import 'package:superset/product/constants/border_radius_general.dart';

final class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.2),
        borderRadius: const BorderRadiusGeneral.allVeryLow(),
      ),
      child: Padding(
        padding: const AppPaddings.small(),
        child: Row(
          children: [
            Icon(
              Icons.fitness_center_rounded,
              size: 16,
              color: Colors.blue.shade600,
            ),
            const SizedBox(width: 4),
            Text(
              ///todo
              '0 exercies',
              style: TextStyle(color: Colors.blue.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
