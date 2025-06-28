import 'package:flutter/material.dart';
import 'package:superset/core/constants/app_padings.dart';

final class NoExercisesFoundAlert extends StatelessWidget {
  const NoExercisesFoundAlert({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const AppPaddings.large(),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.search_off_rounded,
                size: 48,
                color: Colors.orange[400],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'No exercises found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 10, 10, 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
