import 'package:equatable/equatable.dart';
import 'package:superset/core/models/exercise.dart';
import 'package:superset/core/models/workout.dart';

final class WorkoutState extends Equatable {
  const WorkoutState({
    required this.selectedDate,
    this.isLoading = false,
    this.exercises,
    this.workout,
  });

  //ilk açıldıgında selectedDate'i bugünün tarihi olarak ayarlıyoruz
  factory WorkoutState.initial() {
    return WorkoutState(selectedDate: DateTime.now());
  }

  final bool isLoading;
  final DateTime selectedDate;

  /// This is used for all exercises for the app.
  final List<Exercise>? exercises;

  ///tarihi seçtiğinde firebase'e istek atılacak eğer o tarihte bir workout varsa o gelecek
  /// eğer yoksa add exercise butonuna basınca yeni bir workout oluşturulacak
  final Workout? workout;

  @override
  List<Object?> get props => [selectedDate, exercises, isLoading, workout];

  WorkoutState copyWith({
    DateTime? selectedDate,
    List<Exercise>? exercises,
    bool? isLoading,
    Workout? workout,
  }) {
    return WorkoutState(
      selectedDate: selectedDate ?? this.selectedDate,
      exercises: exercises ?? this.exercises,
      isLoading: isLoading ?? this.isLoading,
      workout: workout ?? this.workout,
    );
  }
}
