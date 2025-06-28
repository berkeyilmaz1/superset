enum MuscleGroup {
  chest('chest'),
  shoulders('shoulders'),
  obliques('obliques'),
  biceps('biceps'),
  triceps('triceps'),
  calves('calves'),
  abs('abs'),
  glutes('glutes'),
  hamstrings('hamstrings'),
  quadriceps('quadriceps'),
  forearm('forearm'),
  trapezius('trapezius'),
  abductor('abductor'),
  adductors('adductors'),
  lats('lats'),
  lowerBack('lower_back'),
  neck('neck');

  final String name;
  // ignore: sort_constructors_first
  const MuscleGroup(this.name);
}
