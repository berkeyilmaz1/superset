import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:superset/core/constants/app_padings.dart';
import 'package:superset/core/widgets/info_card.dart';
import 'package:superset/features/workout/cubit/workout_cubit.dart';
import 'package:superset/features/workout/cubit/workout_state.dart';
import 'package:superset/features/workout/view/mixin/workout_view_mixin.dart';
import 'package:superset/features/workout/widgets/calendar_widget.dart';

final class WorkoutView extends StatefulWidget {
  const WorkoutView({super.key});

  @override
  State<WorkoutView> createState() => _WorkoutViewState();
}

class _WorkoutViewState extends State<WorkoutView> with WorkoutViewMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<WorkoutCubit, WorkoutState>(
        builder: (context, state) {
          return Column(
            children: [
              CalendarWidget(
                onDateSelected: (index) {
                  setState(() {
                    context.read<WorkoutCubit>().selectDate(index);
                  });
                },
              ),
              const Divider(),
              const Expanded(
                child: Card(
                  margin: AppPadings.normal(),
                  elevation: 4,
                  child: Padding(
                    padding: AppPadings.normal(),
                    child: Column(
                      children: [
                        WorkoutHeader(),
                        Divider(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

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
