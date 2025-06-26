part of '../view/workout_view.dart';

final class WorkoutHeader extends StatelessWidget {
  const WorkoutHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Today's Workout",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat(
                'MMMM d, y',
              ).format(context.watch<WorkoutCubit>().state.selectedDate),

              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
        const Spacer(),
        const InfoCard(),
      ],
    );
  }
}
