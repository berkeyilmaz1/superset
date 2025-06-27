import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superset/core/constants/border_radius_general.dart';
import 'package:superset/core/models/muscle_group.dart';
import 'package:superset/features/workout/cubit/workout_cubit.dart';
import 'package:superset/features/workout/cubit/workout_state.dart';

final class ExerciseSelectionBottomSheet extends StatefulWidget {
  const ExerciseSelectionBottomSheet({super.key});

  @override
  State<ExerciseSelectionBottomSheet> createState() =>
      _ExerciseSelectionBottomSheetState();
}

class _ExerciseSelectionBottomSheetState
    extends State<ExerciseSelectionBottomSheet> {
  final List<String> muscleGroups = MuscleGroup.values
      .map(
        (e) => e.name,
      )
      .toList();

  @override
  void initState() {
    super.initState();
    fetchExercises();
  }

  Future<void> fetchExercises() async {
    await context.read<WorkoutCubit>().fetchExercises();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusGeneral.bottomSheet(),
      ),
      child: Column(
        children: [
          const DragHandle(),
          const SelectExerciseTitle(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                muscleGroups.length,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: ChoiceChip(
                      label: Text(muscleGroups[index]),
                      selected: false,
                      onSelected: (selected) {},
                    ),
                  );
                },
              ),
            ),
          ),
          const Divider(),
          BlocBuilder<WorkoutCubit, WorkoutState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: state.exercises?.length ?? 0,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        state.exercises?[index].name ?? 'Unknown Exercise',
                      ),
                      subtitle: Text(
                        state.exercises?[index].muscleGroup?.name ??
                            'Unknown Muscle Group',
                      ),
                      onTap: () {
                        // Handle exercise selection
                        Navigator.pop(context, state.exercises?[index]);
                      },
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class SelectExerciseTitle extends StatelessWidget {
  const SelectExerciseTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Select an Exercise',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class DragHandle extends StatelessWidget {
  const DragHandle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 4,
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
