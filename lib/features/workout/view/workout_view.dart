import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:superset/core/constants/app_padings.dart';
import 'package:superset/core/widgets/info_card.dart';
import 'package:superset/features/workout/cubit/workout_cubit.dart';
import 'package:superset/features/workout/cubit/workout_state.dart';
import 'package:superset/features/workout/view/mixin/workout_view_mixin.dart';
import 'package:superset/features/workout/widgets/calendar_widget.dart';
import 'package:superset/features/workout/widgets/custom_button.dart';

part '../widgets/workout_header.dart';

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
              Expanded(
                child: Card(
                  margin: const AppPadings.normal(),
                  elevation: 4,
                  child: Padding(
                    padding: const AppPadings.normal(),
                    child: Column(
                      children: [
                        const WorkoutHeader(),
                        const Divider(),

                        const Expanded(
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
                        ),
                        CustomButton(
                          onPressed: () {},
                        ),
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
