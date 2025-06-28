part of '../view/workout_view.dart';

final class NoExerciseLoggedAlert extends StatelessWidget {
  const NoExerciseLoggedAlert({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 8,
        children: [
          const Icon(
            Icons.fitness_center,
            size: 64,
            color: Colors.grey,
          ),
          const Text(
            LocaleKeys.alerts_no_workout_today,
            style: TextStyle(
              fontSize: 16,
            ),
          ).tr(),
          const Text(
            LocaleKeys.alerts_add_workout,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ).tr(),
        ],
      ),
    );
  }
}
