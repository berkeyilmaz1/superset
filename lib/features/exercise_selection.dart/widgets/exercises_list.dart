part of '../view/exercise_selection_view.dart';
final class ExercisesList extends StatelessWidget {
  const ExercisesList({
    required this.selectedMuscleGroup,
    super.key,
  });

  final String selectedMuscleGroup;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutCubit, WorkoutState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const CustomLoading();
        }

        final filteredExercises = state.exercises?.where((exercise) {
          if (selectedMuscleGroup == 'All') {
            return true;
          }
          return exercise.muscleGroup?.name == selectedMuscleGroup;
        }).toList();

        if (filteredExercises?.isEmpty ?? true) {
          return const NoExercisesFoundAlert();
        }

        return Expanded(
          child: ListView.builder(
            padding: const AppPaddings.normal(),
            itemCount: filteredExercises?.length ?? 0,
            itemBuilder: (context, index) {
              final exercise = filteredExercises![index];
              return ExerciseListItem(exercise: exercise);
            },
          ),
        );
      },
    );
  }
}
