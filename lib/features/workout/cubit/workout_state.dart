import 'package:equatable/equatable.dart';

final class WorkoutState extends Equatable {
  const WorkoutState({required this.selectedDate});

  //ilk açıldıgında selectedDate'i bugünün tarihi olarak ayarlıyoruz
  factory WorkoutState.initial() {
    return WorkoutState(selectedDate: DateTime.now());
  }

  final DateTime selectedDate;
  @override
  // TODO: implement props
  List<Object?> get props => [selectedDate];

  WorkoutState copyWith({DateTime? selectedDate}) {
    return WorkoutState(
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}
