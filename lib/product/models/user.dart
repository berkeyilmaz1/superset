import 'package:equatable/equatable.dart';

final class User with EquatableMixin {
  User({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.picture,
    required this.gender,
    required this.height,
    required this.weight,
    required this.birthDate,
    required this.goal,
    required this.activityLevel,
    required this.trainingExperience,
    required this.premium,
    required this.workouts,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String?,
      picture: json['picture'] as String?,
      gender: json['gender'] as String?,
      height: json['height'] as String?,
      weight: json['weight'] as String?,
      birthDate: json['birthDate'] != null
          ? DateTime.parse(json['birthDate'] as String)
          : null,
      goal: json['goal'] as String?,
      activityLevel: json['activityLevel'] as String?,
      trainingExperience: json['trainingExperience'] as String?,
      premium: json['premium'] as bool?,
      workouts: json['workouts'] as List<dynamic>?,
    );
  }

  final String uid;
  final String email;
  final String? displayName;
  final String? picture;
  final String? gender;
  final String? height;
  final String? weight;
  final DateTime? birthDate;
  final String? goal;
  final String? activityLevel;
  final String? trainingExperience;

  final bool? premium;

  final List<dynamic>? workouts;

  @override
  List<Object?> get props => [
    uid,
    email,
    displayName,
    picture,
    gender,
    height,
    weight,
    birthDate,
    goal,
    activityLevel,
    trainingExperience,
    premium,
    workouts,
  ];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'picture': picture,
      'gender': gender,
      'height': height,
      'weight': weight,
      'birthDate': birthDate?.toIso8601String(),
      'goal': goal,
      'activityLevel': activityLevel,
      'trainingExperience': trainingExperience,
      'premium': premium,
      'workouts': workouts
          ?.map(
            (workout) => {
              'date': workout.date?.toIso8601String(),
              'logs': workout.logs,
              'note': workout.note,
            },
          )
          .toList(),
    };
  }

  User copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? picture,
    String? gender,
    String? height,
    String? weight,
    DateTime? birthDate,
    String? goal,
    String? activityLevel,
    String? trainingExperience,
    bool? premium,
    List<dynamic>? workouts,
  }) {
    return User(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      picture: picture ?? this.picture,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      birthDate: birthDate ?? this.birthDate,
      goal: goal ?? this.goal,
      activityLevel: activityLevel ?? this.activityLevel,
      trainingExperience: trainingExperience ?? this.trainingExperience,
      premium: premium ?? this.premium,
      workouts: workouts ?? this.workouts,
    );
  }
}
