import 'package:equatable/equatable.dart';
import 'package:superset/core/models/exercise.dart';

final class WorkoutState extends Equatable {
  const WorkoutState({
    required this.selectedDate,
    this.isLoading = false,
    this.exercises,
  });

  //ilk açıldıgında selectedDate'i bugünün tarihi olarak ayarlıyoruz
  factory WorkoutState.initial() {
    return WorkoutState(selectedDate: DateTime.now());
  }

  final bool isLoading;
  final DateTime selectedDate;
  final List<Exercise>? exercises;

  @override
  List<Object?> get props => [selectedDate, exercises, isLoading];

  WorkoutState copyWith({
    DateTime? selectedDate,
    List<Exercise>? exercises,
    bool? isLoading,
  }) {
    return WorkoutState(
      selectedDate: selectedDate ?? this.selectedDate,
      exercises: exercises ?? this.exercises,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
