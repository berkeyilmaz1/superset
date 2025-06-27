part of '../view/workout_view.dart';
final class NoExerciseLoggedAlert extends StatelessWidget {
  const NoExerciseLoggedAlert({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 8,
        children: [
          Icon(
            Icons.fitness_center,
            size: 64,
            color: Colors.grey,
          ),
          Text(
            'No exercises logged yet',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            'Add your first exercise to get started!',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
