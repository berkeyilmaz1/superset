import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superset/features/workout/cubit/workout_state.dart';

final class WorkoutCubit extends Cubit<WorkoutState> {
  WorkoutCubit() : super(WorkoutState.initial());

  void selectDate(DateTime date) {
    emit(state.copyWith(selectedDate: date));
  }
}
