import 'package:equatable/equatable.dart';
import 'package:superset/core/models/muscle_group.dart';

final class Exercise with EquatableMixin {
  Exercise({
    this.name,
    this.sets,
    this.rep,
    this.weight,
    this.muscleGroup,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'] as String?,
      sets: json['sets'] as int?,
      rep: json['rep'] as int?,
      weight: json['weight'] as double?,
      muscleGroup: json['muscleGroup'] as MuscleGroup?,
    );
  }
  final String? name;
  final int? sets;
  final int? rep;
  final double? weight;
  final MuscleGroup? muscleGroup;

  @override
  List<Object?> get props => [name, sets, rep, weight, muscleGroup];

  Exercise copyWith({
    String? name,
    int? sets,
    int? rep,
    double? weight,
    MuscleGroup? muscleGroup,
  }) {
    return Exercise(
      name: name ?? this.name,
      sets: sets ?? this.sets,
      rep: rep ?? this.rep,
      weight: weight ?? this.weight,
      muscleGroup: muscleGroup ?? this.muscleGroup,
    );
  }
}
