import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superset/core/constants/app_padings.dart';
import 'package:superset/core/constants/border_radius_general.dart';
import 'package:superset/core/models/exercise.dart';
import 'package:superset/core/models/workout_log.dart';
import 'package:superset/core/widgets/custom_divider.dart';
import 'package:superset/core/widgets/custom_loading.dart';
import 'package:superset/core/widgets/no_exercises_found_alert.dart';
import 'package:superset/features/exercise_selection.dart/view/mixin/exercise_selection_view_mixin.dart';
import 'package:superset/features/workout/cubit/workout_cubit.dart';
import 'package:superset/features/workout/cubit/workout_state.dart';

part '../widgets/bucket_exercise_item.dart';
part '../widgets/exercise_list_item.dart';
part '../widgets/exercise_selection_title.dart';
part '../widgets/exercises_list.dart';
part '../widgets/muscle_group_chips.dart';

final class ExerciseSelectionView extends StatefulWidget {
  const ExerciseSelectionView({super.key});

  @override
  State<ExerciseSelectionView> createState() => _ExerciseSelectionViewState();
}

class _ExerciseSelectionViewState extends State<ExerciseSelectionView>
    with ExerciseSelectionViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ExerciseSelectionTitle(),
        centerTitle: true,
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocBuilder<WorkoutCubit, WorkoutState>(
        builder: (context, state) {
          return Column(
            children: [
              MuscleGroupChips(
                muscleGroups: muscleGroups,
                selectedMuscleGroup: selectedMuscleGroup,
                onMuscleGroupChanged: (String muscleGroup) {
                  setState(() {
                    if (selectedMuscleGroup == muscleGroup) {
                      selectedMuscleGroup =
                          ExerciseSelectionViewMixin.allMuscleGroupsKey;
                    } else {
                      selectedMuscleGroup = muscleGroup;
                    }
                  });
                },
              ),
              if (state.workoutBucket != null &&
                  state.workoutBucket!.logs != null &&
                  state.workoutBucket!.logs!.isNotEmpty)
                Container(
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
                            final workoutLog =
                                state.workoutBucket?.logs?[index];
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
                ),
              const CustomDivider(),
              ExercisesList(selectedMuscleGroup: selectedMuscleGroup),
            ],
          );
        },
      ),
    );
  }
}
