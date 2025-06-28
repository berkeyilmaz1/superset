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
      muscleGroup: _parseMuscleGroup(json['muscleGroup'] as String?),
    );
  }

  static MuscleGroup? _parseMuscleGroup(String? muscleGroupName) {
    if (muscleGroupName == null) return null;

    try {
      return MuscleGroup.values.firstWhere(
        (group) => group.name == muscleGroupName,
      );
    } catch (e) {
      return null;
    }
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
