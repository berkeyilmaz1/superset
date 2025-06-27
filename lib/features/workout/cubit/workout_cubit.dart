import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superset/core/service/exercise_service.dart';
import 'package:superset/features/workout/cubit/workout_state.dart';

final class WorkoutCubit extends Cubit<WorkoutState> {
  WorkoutCubit() : super(WorkoutState.initial());

  final ExerciseService _exerciseService = ExerciseService();

  void selectDate(DateTime date) {
    emit(state.copyWith(selectedDate: date));
  }

  Future<void> fetchExercises() async {
    emit(state.copyWith(isLoading: true));
    try {
      final exercises = await _exerciseService.fetchExercises();
      emit(
        state.copyWith(
          exercises: exercises,
          isLoading: false,
        ),
      );
    } catch (e) {
      print('Error fetching exercises: $e');
      emit(
        state.copyWith(
          isLoading: false,
          exercises: [], // Boş liste döndür
        ),
      );
    }
  }
}
