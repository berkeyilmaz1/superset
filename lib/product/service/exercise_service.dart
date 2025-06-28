import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:superset/product/models/exercise.dart';

final class ExerciseService {
  Future<List<Exercise>> fetchExercises() async {
    final response = await rootBundle.loadString('assets/exercises.json');
    final data = json.decode(response) as List<dynamic>;
    return data
        .map((json) => Exercise.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
