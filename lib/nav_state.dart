import 'package:equatable/equatable.dart';

/// Navigation state for managing the current index of a navigation bar.
/// This class extends [Equatable] to enable value comparison,
final class NavState extends Equatable {
  const NavState({this.currentIndex = 0});

  final int currentIndex;
  @override
  List<Object?> get props => [currentIndex];

  /// Creates a copy of the current state with an optional new index.
  /// If [currentIndex] is not provided, it retains the current index.
  ///This is useful for updating the state without losing other properties.
  NavState copyWith({int? currentIndex}) {
    return NavState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
