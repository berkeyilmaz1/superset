part of '../view/exercise_selection_view.dart';
final class ExerciseSelectionTitle extends StatelessWidget {
  const ExerciseSelectionTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Select an Exercise',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }
}