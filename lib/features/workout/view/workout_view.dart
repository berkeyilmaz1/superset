import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:muscle_selector/muscle_selector.dart';
import 'package:superset/features/exercise_selection.dart/view/exercise_selection_view.dart';
import 'package:superset/features/workout/cubit/workout_cubit.dart';
import 'package:superset/features/workout/cubit/workout_state.dart';
import 'package:superset/features/workout/widgets/calendar_widget.dart';
import 'package:superset/features/workout/widgets/custom_button.dart';
import 'package:superset/product/constants/app_padings.dart';
import 'package:superset/product/constants/string_constants.dart';
import 'package:superset/product/initialize/localization/locale_keys.g.dart';
import 'package:superset/product/widgets/info_card.dart';

part '../widgets/custom_body_map.dart';
part '../widgets/no_exercise_logged_alert.dart';
part '../widgets/workout_header.dart';

final class WorkoutView extends StatefulWidget {
  const WorkoutView({super.key});

  @override
  State<WorkoutView> createState() => _WorkoutViewState();
}

class _WorkoutViewState extends State<WorkoutView> {
  final GlobalKey<MusclePickerMapState> _mapKey = GlobalKey();
  final hasWorkout = false;
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
                  margin: const AppPaddings.normal(),
                  elevation: 4,
                  child: Padding(
                    padding: const AppPaddings.normal(),
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
                          buttonText: LocaleKeys.button_texts_select_workout,
                          onPressed: () {
                            final workoutCubit = context.read<WorkoutCubit>();
                            Navigator.of(context).push(
                              MaterialPageRoute<ExerciseSelectionView>(
                                builder: (context) => BlocProvider.value(
                                  value: workoutCubit,
                                  child: const ExerciseSelectionView(),
                                ),
                              ),
                            );
                          },
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
