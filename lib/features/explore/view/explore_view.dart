import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superset/product/constants/app_padings.dart';
import 'package:superset/product/constants/border_radius_general.dart';
import 'package:superset/product/models/exercise.dart';
import 'package:superset/product/models/muscle_group.dart';
import 'package:superset/product/widgets/custom_loading.dart';
import 'package:superset/product/widgets/no_exercises_found_alert.dart';
import 'package:superset/features/workout/cubit/workout_cubit.dart';
import 'package:superset/features/workout/cubit/workout_state.dart';

final class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  static const String _allMuscleGroupsKey = 'All';

  String selectedMuscleGroup = _allMuscleGroupsKey;
  late final List<String> muscleGroups;

  @override
  void initState() {
    super.initState();
    muscleGroups = [
      _allMuscleGroupsKey,
      ...MuscleGroup.values.map((e) => e.name),
    ];
    fetchExercises();
  }

  Future<void> fetchExercises() async {
    await context.read<WorkoutCubit>().fetchExercises();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _MuscleGroupChips(
            muscleGroups: muscleGroups,
            selectedMuscleGroup: selectedMuscleGroup,
            onMuscleGroupChanged: (String muscleGroup) {
              setState(() {
                if (selectedMuscleGroup == muscleGroup) {
                  selectedMuscleGroup = _allMuscleGroupsKey;
                } else {
                  selectedMuscleGroup = muscleGroup;
                }
              });
            },
          ),
          Container(
            height: 1,
            margin: const AppPaddings.normal(),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.grey.withOpacity(0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          _ExercisesList(selectedMuscleGroup: selectedMuscleGroup),
        ],
      ),
    );
  }
}

final class _MuscleGroupChips extends StatelessWidget {
  const _MuscleGroupChips({
    required this.muscleGroups,
    required this.selectedMuscleGroup,
    required this.onMuscleGroupChanged,
  });

  final List<String> muscleGroups;
  final String selectedMuscleGroup;
  final ValueChanged<String> onMuscleGroupChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const AppPaddings.medium(),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const AppPaddings.medium(),
          child: Row(
            children: muscleGroups.map((muscleGroup) {
              final isSelected = selectedMuscleGroup == muscleGroup;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: FilterChip(
                  label: Text(
                    muscleGroup,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: isSelected ? Colors.white : Colors.grey[700],
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (_) => onMuscleGroupChanged(muscleGroup),
                  backgroundColor: Colors.grey[200],
                  selectedColor: Colors.blue[600],
                  checkmarkColor: Colors.white,
                  elevation: isSelected ? 4 : 0,
                  shadowColor: Colors.blue.withOpacity(0.3),
                  padding: const AppPaddings.chip(),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadiusGeneral.all(),
                    side: BorderSide(
                      color: isSelected
                          ? Colors.blue[600]!
                          : Colors.transparent,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

final class _ExercisesList extends StatelessWidget {
  const _ExercisesList({
    required this.selectedMuscleGroup,
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
              return _ExerciseListItem(exercise: exercise);
            },
          ),
        );
      },
    );
  }
}

final class _ExerciseListItem extends StatelessWidget {
  const _ExerciseListItem({
    required this.exercise,
  });

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadiusGeneral.allMedium(),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: Colors.grey.withOpacity(0.1),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: const BorderRadiusGeneral.allMedium(),
          child: Padding(
            padding: const AppPaddings.normal(),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue[400]!,
                        Colors.blue[600]!,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadiusGeneral.allMedium(),
                  ),
                  child: const Icon(
                    Icons.fitness_center_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        exercise.name ?? 'Unknown Exercise',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black87,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          exercise.muscleGroup?.name ?? 'Unknown Muscle Group',
                          style: TextStyle(
                            color: Colors.blue[700],
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
