part of '../view/workout_view.dart';

final class CustomBodyMap extends StatelessWidget {
  const CustomBodyMap({
    required GlobalKey<MusclePickerMapState> mapKey,
    super.key,
    this.initialSelectedGroups,
  }) : _mapKey = mapKey;

  final GlobalKey<MusclePickerMapState> _mapKey;
  final List<String>? initialSelectedGroups;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        /// This padding is used for the centering of the human body map
        padding: const EdgeInsets.only(right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MusclePickerMap(
              key: _mapKey,
              map: Maps.BODY,
              selectedColor: Colors.lightBlueAccent,
              strokeColor: Colors.grey.shade800,
              isEditing: true,
              initialSelectedGroups: initialSelectedGroups,
              onChanged: (muscles) {},
            ),
          ],
        ),
      ),
    );
  }
}
