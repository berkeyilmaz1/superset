import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:superset/core/constants/app_padings.dart';
import 'package:superset/features/workout/cubit/workout_cubit.dart';
import 'package:superset/features/workout/widgets/calendar_card.dart';

final class CalendarWidget extends StatefulWidget {
  const CalendarWidget({
    required this.onDateSelected,
    super.key,
  });
  final void Function(DateTime) onDateSelected;

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const AppPadings.normal(),
        child: Row(
          children: List.generate(60, (index) {
            final date = DateTime.now().add(Duration(days: index));
            final day = DateFormat.d().format(date);
            final weekday = DateFormat.E().format(date);
            final isSelected = selectedIndex == index;
            return CalendarCard(
              isSelected: isSelected,
              day: day,
              weekday: weekday,
              onTap: () {
                setState(() {
                  selectedIndex = index;
                  context.read<WorkoutCubit>().selectDate(date);
                });
              },
            );
          }),
        ),
      ),
    );
  }
}
