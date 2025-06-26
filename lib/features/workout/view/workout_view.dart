import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:muscle_selector/muscle_selector.dart';
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
  final GlobalKey<MusclePickerMapState> _mapKey = GlobalKey();
  final hasWorkout = true;
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
                        if (hasWorkout)
                          CustomBodyMap(
                            mapKey: _mapKey,
                            // Pass the initial selected muscle groups
                            initialSelectedGroups: const [],
                          )
                        else
                          const NoExerciseLoggedAlert(),
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

final class CustomBodyMap extends StatelessWidget {
  const CustomBodyMap({
    required GlobalKey<MusclePickerMapState> mapKey,
    super.key,
    this.initialSelectedGroups,
  }) : _mapKey = mapKey;

  final GlobalKey<MusclePickerMapState> _mapKey;
  final List<String>? initialSelectedGroups;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        /// This padding is used for the centering of the human body map
        padding: const EdgeInsets.only(right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MusclePickerMap(
              key: _mapKey,
              map: Maps.BODY,
              selectedColor: Colors.lightBlueAccent,
              strokeColor: Colors.grey.shade800,
              isEditing: true,
              initialSelectedGroups: initialSelectedGroups,
              onChanged: (muscles) {},
            ),
          ],
        ),
      ),
    );
  }
}
