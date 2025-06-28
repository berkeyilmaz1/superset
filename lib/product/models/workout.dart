import 'package:equatable/equatable.dart';
import 'package:superset/product/models/workout_log.dart';

final class Workout with EquatableMixin {
  Workout({
    this.date,
    this.logs,
    this.note,
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      date: json['date'] as DateTime?,
      logs: json['logs'] as List<WorkoutLog>?,
      note: json['note'] as String?,
    );
  }
  final DateTime? date;
  final List<WorkoutLog>? logs;
  final String? note;

  @override
  List<Object?> get props => [
    date,
    logs,
    note,
  ];

  Workout copyWith({
    DateTime? date,
    List<WorkoutLog>? logs,
    String? note,
  }) {
    return Workout(
      date: date ?? this.date,
      logs: logs ?? this.logs,
      note: note ?? this.note,
    );
  }
}
