import 'package:equatable/equatable.dart';
import 'package:superset/core/models/exercise.dart';

final class Workout with EquatableMixin {
  Workout({
    this.date,
    this.exercises,
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      date: json['date'] as DateTime?,
      exercises: json['exercises'] as List<Exercise>?,
    );
  }
  final DateTime? date;
  final List<Exercise>? exercises;

  @override
  List<Object?> get props => [
    date,
    exercises,
  ];

  Workout copyWith({
    DateTime? date,
    List<Exercise>? exercises,
  }) {
    return Workout(
      date: date ?? this.date,
      exercises: exercises ?? this.exercises,
    );
  }
}
