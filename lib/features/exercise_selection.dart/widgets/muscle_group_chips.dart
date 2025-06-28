part of '../view/exercise_selection_view.dart';
final class MuscleGroupChips extends StatelessWidget {
  const MuscleGroupChips({
    required this.muscleGroups,
    required this.selectedMuscleGroup,
    required this.onMuscleGroupChanged,
    super.key,
  });

  final List<String> muscleGroups;
  final String selectedMuscleGroup;
  final ValueChanged<String> onMuscleGroupChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const AppPaddings.medium(),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const AppPaddings.medium(),
          child: Row(
            children: muscleGroups.map((muscleGroup) {
              final isSelected = selectedMuscleGroup == muscleGroup;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: FilterChip(
                  label: Text(
                    muscleGroup,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: isSelected ? Colors.white : Colors.grey[700],
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (_) => onMuscleGroupChanged(muscleGroup),
                  backgroundColor: Colors.grey[200],
                  selectedColor: Colors.blue[600],
                  checkmarkColor: Colors.white,
                  elevation: isSelected ? 4 : 0,
                  shadowColor: Colors.blue.withOpacity(0.3),
                  padding: const AppPaddings.chip(),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadiusGeneral.all(),
                    side: BorderSide(
                      color: isSelected
                          ? Colors.blue[600]!
                          : Colors.transparent,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
