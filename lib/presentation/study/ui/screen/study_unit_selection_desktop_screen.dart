import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e4u_application/app/app.dart';
import 'package:e4u_application/presentation/study/domain/models/study_models.dart';
import 'package:e4u_application/presentation/study/ui/controllers/study_session_controller.dart';
import 'package:e4u_application/presentation/study/ui/widgets/study_widgets.dart';

/// Desktop screen for unit selection.
class StudyUnitSelectionDesktopScreen extends StatefulWidget {
  const StudyUnitSelectionDesktopScreen({
    super.key,
    required this.controller,
    required this.onUnitSelected,
    required this.onBack,
  });

  final StudySessionController controller;
  final void Function(StudyUnit unit, int lessonIndex) onUnitSelected;
  final VoidCallback onBack;

  @override
  State<StudyUnitSelectionDesktopScreen> createState() =>
      _StudyUnitSelectionDesktopScreenState();
}

class _StudyUnitSelectionDesktopScreenState
    extends State<StudyUnitSelectionDesktopScreen> {
  int? _selectedLessonIndex;
  int _wordsToLearn = 5;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: ColorManager.grey50,
          body: Row(
            children: [
              // Left side: Header and unit list
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    _buildHeader(),
                    Expanded(
                      child: _buildUnitList(),
                    ),
                  ],
                ),
              ),

              // Right side: Unit details
              Container(
                width: 400.w.clamp(350, 480),
                decoration: const BoxDecoration(
                  color: ColorManager.baseWhite,
                  border: Border(
                    left: BorderSide(
                      color: ColorManager.grey200,
                      width: 1,
                    ),
                  ),
                ),
                child: widget.controller.selectedUnit != null
                    ? _buildUnitDetails(widget.controller.selectedUnit!)
                    : _buildEmptyDetails(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorManager.purpleHard,
            Color(0xFF9C27B0),
          ],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            GestureDetector(
              onTap: widget.onBack,
              child: Container(
                width: 48.r,
                height: 48.r,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.arrow_back_rounded,
                  size: 24.r,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choose a Unit',
                    style: TextStyle(
                      fontSize: 28.sp.clamp(24, 32),
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Select a unit to start learning vocabulary',
                    style: TextStyle(
                      fontSize: 16.sp.clamp(14, 18),
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
            // Filter button
            GestureDetector(
              onTap: () => _showFilterDialog(context),
              child: Container(
                width: 48.r,
                height: 48.r,
                decoration: BoxDecoration(
                  color: widget.controller.hasActiveFilter
                      ? Colors.white
                      : Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.filter_list_rounded,
                  size: 24.r,
                  color: widget.controller.hasActiveFilter
                      ? ColorManager.purpleHard
                      : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUnitList() {
    if (widget.controller.isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: ColorManager.purpleHard,
          strokeWidth: 3.w,
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(24.w),
      itemCount: widget.controller.units.length,
      itemBuilder: (context, index) {
        final unit = widget.controller.units[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: StudyUnitCard(
            unit: unit,
            isSelected: widget.controller.selectedUnit?.id == unit.id,
            onTap: () {
              widget.controller.selectUnitById(unit.id);
              setState(() {
                _selectedLessonIndex = null;
                _wordsToLearn = 5;
              });
            },
          ),
        );
      },
    );
  }

  Widget _buildEmptyDetails() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.menu_book_rounded,
            size: 64.r,
            color: ColorManager.grey300,
          ),
          SizedBox(height: 16.h),
          Text(
            'Select a unit',
            style: TextStyle(
              fontSize: 18.sp.clamp(16, 20),
              fontWeight: FontWeight.w600,
              color: ColorManager.grey500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Choose a unit from the list\nto view details',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp.clamp(12, 16),
              fontWeight: FontWeight.w400,
              color: ColorManager.grey400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnitDetails(StudyUnit unit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Unit title
        Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                unit.title,
                style: TextStyle(
                  fontSize: 24.sp.clamp(20, 28),
                  fontWeight: FontWeight.w700,
                  color: ColorManager.grey950,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                unit.description,
                style: TextStyle(
                  fontSize: 14.sp.clamp(12, 16),
                  fontWeight: FontWeight.w400,
                  color: ColorManager.grey500,
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  _buildInfoChip(
                    Icons.layers_rounded,
                    '${unit.totalLessons} lessons',
                  ),
                  SizedBox(width: 12.w),
                  _buildInfoChip(
                    Icons.text_fields_rounded,
                    '${unit.totalWords} words',
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(height: 1, color: ColorManager.grey200),

        // Lessons selection
        Padding(
          padding: EdgeInsets.all(24.w),
          child: Text(
            'Select a Lesson',
            style: TextStyle(
              fontSize: 16.sp.clamp(14, 18),
              fontWeight: FontWeight.w600,
              color: ColorManager.grey700,
            ),
          ),
        ),

        // Lessons list
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            itemCount: unit.lessons.length,
            itemBuilder: (context, index) {
              final lesson = unit.lessons[index];
              final isSelected = _selectedLessonIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedLessonIndex = index;
                    _wordsToLearn = lesson.words.length.clamp(1, 5);
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 12.h),
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? ColorManager.purpleLight
                        : ColorManager.grey50,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: isSelected
                          ? ColorManager.purpleHard
                          : ColorManager.grey200,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36.r,
                        height: 36.r,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? ColorManager.purpleHard
                              : ColorManager.grey200,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              fontSize: 14.sp.clamp(12, 16),
                              fontWeight: FontWeight.w700,
                              color: isSelected
                                  ? Colors.white
                                  : ColorManager.grey600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Lesson ${index + 1}',
                              style: TextStyle(
                                fontSize: 15.sp.clamp(14, 17),
                                fontWeight: FontWeight.w600,
                                color: ColorManager.grey950,
                              ),
                            ),
                            Text(
                              '${lesson.words.length} words',
                              style: TextStyle(
                                fontSize: 13.sp.clamp(12, 15),
                                fontWeight: FontWeight.w500,
                                color: ColorManager.grey500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          Icons.check_circle_rounded,
                          size: 24.r,
                          color: ColorManager.purpleHard,
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        // Word count slider
        if (_selectedLessonIndex != null) _buildWordCountSelector(unit),

        // Start button
        Padding(
          padding: EdgeInsets.all(24.w),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _selectedLessonIndex != null
                  ? () {
                      widget.onUnitSelected(unit, _selectedLessonIndex!);
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.purpleHard,
                disabledBackgroundColor: ColorManager.grey300,
                padding: EdgeInsets.symmetric(vertical: 18.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Start Learning ($_wordsToLearn words)',
                style: TextStyle(
                  fontSize: 16.sp.clamp(14, 18),
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: ColorManager.grey100,
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14.r,
            color: ColorManager.grey600,
          ),
          SizedBox(width: 6.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 13.sp.clamp(12, 15),
              fontWeight: FontWeight.w500,
              color: ColorManager.grey700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWordCountSelector(StudyUnit unit) {
    final maxWords = _selectedLessonIndex != null
        ? unit.lessons[_selectedLessonIndex!].words.length
        : 5;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: ColorManager.grey200, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Words to learn',
                style: TextStyle(
                  fontSize: 14.sp.clamp(12, 16),
                  fontWeight: FontWeight.w600,
                  color: ColorManager.grey700,
                ),
              ),
              Text(
                '$_wordsToLearn words',
                style: TextStyle(
                  fontSize: 14.sp.clamp(12, 16),
                  fontWeight: FontWeight.w600,
                  color: ColorManager.purpleHard,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 6.h,
              activeTrackColor: ColorManager.purpleHard,
              inactiveTrackColor: ColorManager.grey200,
              thumbColor: ColorManager.purpleHard,
              overlayColor: ColorManager.purpleHard.withOpacity(0.2),
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.r),
            ),
            child: Slider(
              value: _wordsToLearn.toDouble(),
              min: 1,
              max: maxWords.toDouble(),
              divisions: maxWords > 1 ? maxWords - 1 : 1,
              onChanged: (value) {
                setState(() {
                  _wordsToLearn = value.round();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => _FilterDialog(
        controller: widget.controller,
      ),
    );
  }
}

/// Dialog widget for filtering units by status on desktop
class _FilterDialog extends StatefulWidget {
  const _FilterDialog({
    required this.controller,
  });

  final StudySessionController controller;

  @override
  State<_FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<_FilterDialog> {
  late Set<StudyUnitStatus> _selectedFilters;

  @override
  void initState() {
    super.initState();
    _selectedFilters = Set.from(widget.controller.statusFilter);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorManager.baseWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        width: 400.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filter by Status',
                    style: TextStyle(
                      fontSize: 20.sp.clamp(18, 22),
                      fontWeight: FontWeight.w700,
                      color: ColorManager.grey950,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedFilters.clear();
                      });
                    },
                    child: Text(
                      'Clear All',
                      style: TextStyle(
                        fontSize: 14.sp.clamp(12, 16),
                        fontWeight: FontWeight.w600,
                        color: ColorManager.purpleHard,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Filter options
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: StudyUnitStatus.values.map((status) {
                    return _buildFilterOption(status);
                  }).toList(),
                ),
              ),
            ),

            // Action buttons
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        side: const BorderSide(color: ColorManager.grey300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 14.sp.clamp(12, 16),
                          fontWeight: FontWeight.w600,
                          color: ColorManager.grey700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        widget.controller.setStatusFilter(_selectedFilters);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.purpleHard,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        _selectedFilters.isEmpty
                            ? 'Show All'
                            : 'Apply (${_selectedFilters.length})',
                        style: TextStyle(
                          fontSize: 14.sp.clamp(12, 16),
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterOption(StudyUnitStatus status) {
    final isSelected = _selectedFilters.contains(status);
    final (String label, Color color, IconData icon) = switch (status) {
      StudyUnitStatus.completed => (
          'Completed',
          ColorManager.success,
          Icons.check_circle_rounded,
        ),
      StudyUnitStatus.inProgress => (
          'In Progress',
          ColorManager.warning,
          Icons.schedule_rounded,
        ),
      StudyUnitStatus.locked => (
          'Locked',
          ColorManager.grey500,
          Icons.lock_rounded,
        ),
      StudyUnitStatus.notStarted => (
          'Not Started',
          ColorManager.purpleHard,
          Icons.play_circle_outline_rounded,
        ),
    };

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedFilters.remove(status);
          } else {
            _selectedFilters.add(status);
          }
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : ColorManager.grey50,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected ? color : ColorManager.grey200,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 32.r,
              height: 32.r,
              decoration: BoxDecoration(
                color: isSelected ? color : ColorManager.grey200,
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Icon(
                icon,
                size: 16.r,
                color: isSelected ? Colors.white : ColorManager.grey600,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14.sp.clamp(12, 16),
                  fontWeight: FontWeight.w600,
                  color: ColorManager.grey950,
                ),
              ),
            ),
            if (isSelected)
              Container(
                padding: EdgeInsets.all(2.r),
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_rounded,
                  size: 12.r,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
