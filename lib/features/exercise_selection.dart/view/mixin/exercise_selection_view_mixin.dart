import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superset/product/models/muscle_group.dart';
import 'package:superset/product/models/workout.dart';
import 'package:superset/features/exercise_selection.dart/view/exercise_selection_view.dart';
import 'package:superset/features/workout/cubit/workout_cubit.dart';

mixin ExerciseSelectionViewMixin on State<ExerciseSelectionView> {
  static const String allMuscleGroupsKey = 'All';

  String selectedMuscleGroup = allMuscleGroupsKey;
  late final List<String> muscleGroups;
  late final Workout workoutBucket;

  @override
  void initState() {
    super.initState();
    muscleGroups = [
      allMuscleGroupsKey,
      ...MuscleGroup.values.map((e) => e.name),
    ];
    fetchExercises();
  }

  Future<void> fetchExercises() async {
    await context.read<WorkoutCubit>().fetchExercises();
  }
}
