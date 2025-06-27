import 'package:equatable/equatable.dart';
import 'package:superset/core/models/exercise.dart';

final class WorkoutLog with EquatableMixin {
  WorkoutLog({
    required this.exercise,
    required this.sets,
    required this.reps,
    required this.weight,
    required this.date,
  });

  factory WorkoutLog.fromJson(Map<String, dynamic> json) {
    return WorkoutLog(
      exercise: Exercise.fromJson(json['exercise'] as Map<String, dynamic>),
      sets: json['sets'] as int,
      reps: json['reps'] as int,
      weight: (json['weight'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
    );
  }
  final Exercise exercise;
  final int sets;
  final int reps;
  final double weight;
  final DateTime date;

  @override
  List<Object?> get props => [
    exercise,
    sets,
    reps,
    weight,
    date,
  ];

  WorkoutLog copyWith({
    Exercise? exercise,
    int? sets,
    int? reps,
    double? weight,
    DateTime? date,
  }) {
    return WorkoutLog(
      exercise: exercise ?? this.exercise,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      weight: weight ?? this.weight,
      date: date ?? this.date,
    );
  }
}
