import 'package:equatable/equatable.dart';
import 'package:superset/core/models/muscle_group.dart';

final class Exercise with EquatableMixin {
  Exercise({
    this.name,

    this.muscleGroup,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'] as String?,
      muscleGroup: json['muscleGroup'] as MuscleGroup?,
    );
  }
  final String? name;
  final MuscleGroup? muscleGroup;

  @override
  List<Object?> get props => [name, muscleGroup];

  Exercise copyWith({
    String? name,

    MuscleGroup? muscleGroup,
  }) {
    return Exercise(
      name: name ?? this.name,

      muscleGroup: muscleGroup ?? this.muscleGroup,
    );
  }
}
