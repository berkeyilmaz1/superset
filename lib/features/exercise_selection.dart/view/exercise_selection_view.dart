import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superset/features/exercise_selection.dart/view/mixin/exercise_selection_view_mixin.dart';
import 'package:superset/features/workout/cubit/workout_cubit.dart';
import 'package:superset/features/workout/cubit/workout_state.dart';
import 'package:superset/features/workout/widgets/custom_button.dart';
import 'package:superset/product/constants/app_padings.dart';
import 'package:superset/product/constants/border_radius_general.dart';
import 'package:superset/product/initialize/localization/locale_keys.g.dart';
import 'package:superset/product/models/exercise.dart';
import 'package:superset/product/models/workout_log.dart';
import 'package:superset/product/widgets/custom_divider.dart';
import 'package:superset/product/widgets/custom_loading.dart';
import 'package:superset/product/widgets/no_exercises_found_alert.dart';

part '../widgets/bucket_exercise_item.dart';
part '../widgets/exercise_list_item.dart';
part '../widgets/exercise_selection_title.dart';
part '../widgets/exercises_list.dart';
part '../widgets/muscle_group_chips.dart';
part '../widgets/selected_exercises_section.dart';

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
                const SelectedExercisesSection(),
              const CustomDivider(),
              ExercisesList(selectedMuscleGroup: selectedMuscleGroup),
              Padding(
                padding: const AppPaddings.large(),
                child: CustomButton(
                  onPressed: () {},
                  buttonText: LocaleKeys.button_texts_save_workout,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
