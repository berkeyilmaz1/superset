import 'package:flutter/material.dart';
import 'package:superset/workout/mixin/workout_view_mixin.dart';
import 'package:superset/workout/widgets/calendar_widget.dart';

final class WorkoutView extends StatefulWidget {
  const WorkoutView({super.key});

  @override
  State<WorkoutView> createState() => _WorkoutViewState();
}

class _WorkoutViewState extends State<WorkoutView> with WorkoutViewMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          CalendarWidget(
            onDateSelected: (index) {
              setState(() {
                // selectedIndex = index;
                //buraya datei haber vericeksin ki aşağıda o date ile ilgili verileri çekebilelim
              });
            },
          ),
          const Divider(),
          
        ],
      ),
    );
  }
}
