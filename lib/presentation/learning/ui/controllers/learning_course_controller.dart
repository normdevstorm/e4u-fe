import 'package:flutter/material.dart';
import 'package:e4u_application/app/app.dart';

/// Shared controller for learning course screen logic.
/// Manages tab selection, module expansion state, and curriculum filtering.
class LearningCourseController {
  int selectedTabIndex = 0; // 0: Dashboard, 1: Notes, 2: Resources

  // Track which modules are expanded
  final Map<int, bool> moduleExpandedState = {
    0: false, // MODULE 1
    1: false, // MODULE 2
    2: true, // MODULE 3 (expanded by default as per Figma)
    3: false, // MODULE 4
  };

  // Track selected curriculum filter
  String selectedCurriculum = 'All Curriculums';

  /// Toggle module expansion state
  void toggleModule(int moduleIndex) {
    moduleExpandedState[moduleIndex] =
        !(moduleExpandedState[moduleIndex] ?? false);
  }

  /// Set selected tab
  void setSelectedTab(int index) {
    selectedTabIndex = index;
  }

  /// Set selected curriculum
  void setSelectedCurriculum(String curriculum) {
    selectedCurriculum = curriculum;
  }

  /// Show curriculum dropdown bottom sheet
  /// Returns a Future that completes when a curriculum is selected
  Future<void> showCurriculumDropdown(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: ColorManager.baseWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: ColorManager.grey300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Select Curriculum',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: ColorManager.grey950,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildCurriculumOption(context, 'All Curriculums'),
            _buildCurriculumOption(context, 'Curriculum 1'),
            _buildCurriculumOption(context, 'Curriculum 2'),
            _buildCurriculumOption(context, 'Curriculum 3'),
            _buildCurriculumOption(context, 'Curriculum 4'),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
          ],
        ),
      ),
    );
  }

  Widget _buildCurriculumOption(BuildContext context, String curriculum) {
    final bool isSelected = selectedCurriculum == curriculum;
    return Builder(
      builder: (context) => InkWell(
        onTap: () {
          setSelectedCurriculum(curriculum);
          Navigator.pop(context);
          // Notify parent widget to rebuild
          if (context.mounted) {
            // The parent screen will handle the rebuild via setState
          }
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          color: isSelected ? ColorManager.purpleLight : Colors.transparent,
          child: Text(
            curriculum,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color:
                  isSelected ? ColorManager.purpleHard : ColorManager.grey950,
            ),
          ),
        ),
      ),
    );
  }
}
