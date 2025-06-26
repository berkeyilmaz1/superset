import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superset/features/app_nav_bar/cubit/nav_state.dart';

final class NavCubit extends Cubit<NavState> {
  NavCubit() : super(const NavState());

  void changeIndex(int index) {
    if (index != state.currentIndex) {
      emit(state.copyWith(currentIndex: index));
    }
  }
}
