part of '../view/exercise_selection_view.dart';

final class SelectedExercisesSection extends StatelessWidget {
  const SelectedExercisesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutCubit, WorkoutState>(
      builder: (context, state) {
        return Container(
          constraints: const BoxConstraints(maxHeight: 200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const AppPaddings.normal(),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green[600],
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Selected Exercises (${state.workoutBucket!.logs!.length})',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: state.workoutBucket?.logs?.length ?? 0,
                  itemBuilder: (context, index) {
                    final workoutLog = state.workoutBucket?.logs?[index];
                    if (workoutLog == null) {
                      return const SizedBox.shrink();
                    }
                    if (workoutLog.exercise == null) {
                      return const SizedBox.shrink();
                    }
                    return BucketExerciseItem(
                      exercise: workoutLog.exercise!,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
