import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superset/features/workout/cubit/workout_state.dart';
import 'package:superset/product/models/workout.dart';
import 'package:superset/product/models/workout_log.dart';
import 'package:superset/product/service/exercise_service.dart';

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

  void createWorkoutBucket(String? note) {
    final workoutBucket = Workout(
      date: state.selectedDate,
      note: note,
    );
    emit(state.copyWith(workoutBucket: workoutBucket));
  }

  void addExerciseToWorkoutBucket(WorkoutLog log, String? note) {
    // Eğer workoutBucket yoksa önce oluştur
    if (state.workoutBucket == null) {
      createWorkoutBucket(note);
    }

    final updatedLogs = List<WorkoutLog>.from(state.workoutBucket?.logs ?? [])
      ..add(log);
    final updatedWorkoutBucket = state.workoutBucket?.copyWith(
      logs: updatedLogs,
    );
    emit(state.copyWith(workoutBucket: updatedWorkoutBucket));
  }

  void removeExerciseFromWorkoutBucket(WorkoutLog log) {
    final updatedLogs = List<WorkoutLog>.from(state.workoutBucket?.logs ?? [])
      ..remove(log);
    final updatedWorkoutBucket = state.workoutBucket?.copyWith(
      logs: updatedLogs,
    );
    emit(state.copyWith(workoutBucket: updatedWorkoutBucket));
  }

  void clearWorkoutBucket() {
    emit(state.copyWith(workoutBucket: null));
  }
}
