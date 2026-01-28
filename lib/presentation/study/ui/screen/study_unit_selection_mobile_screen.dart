import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e4u_application/app/app.dart';
import 'package:e4u_application/presentation/study/domain/models/study_models.dart';
import 'package:e4u_application/presentation/study/ui/controllers/study_session_controller.dart';
import 'package:e4u_application/presentation/study/ui/widgets/study_widgets.dart';

/// Mobile screen for unit selection.
class StudyUnitSelectionMobileScreen extends StatelessWidget {
  const StudyUnitSelectionMobileScreen({
    super.key,
    required this.controller,
    required this.onUnitSelected,
    required this.onBack,
  });

  final StudySessionController controller;
  final void Function(StudyUnit unit, int lessonIndex) onUnitSelected;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: ColorManager.grey50,
          body: CustomScrollView(
            slivers: [
              // App bar
              SliverAppBar(
                backgroundColor: ColorManager.baseWhite,
                surfaceTintColor: Colors.transparent,
                pinned: true,
                expandedHeight: 160.h,
                leading: GestureDetector(
                  onTap: onBack,
                  child: Container(
                    margin: EdgeInsets.all(8.r),
                    decoration: const BoxDecoration(
                      color: ColorManager.grey100,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_back_rounded,
                      size: 22.r,
                      color: ColorManager.grey700,
                    ),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
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
                      child: Padding(
                        padding: EdgeInsets.all(20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
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
                                fontSize: 14.sp.clamp(12, 16),
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Loading indicator
              if (controller.isLoading)
                SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: ColorManager.purpleHard,
                      strokeWidth: 3.w,
                    ),
                  ),
                ),

              // Unit list
              if (!controller.isLoading)
                SliverPadding(
                  padding: EdgeInsets.all(16.w),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final unit = controller.units[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: StudyUnitCard(
                            unit: unit,
                            isSelected: controller.selectedUnit?.id == unit.id,
                            onTap: () {
                              controller.selectUnitById(unit.id);
                              _showLessonSelectionSheet(context, unit);
                            },
                          ),
                        );
                      },
                      childCount: controller.units.length,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _showLessonSelectionSheet(BuildContext context, StudyUnit unit) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _LessonSelectionSheet(
        unit: unit,
        onLessonSelected: (lessonIndex) {
          Navigator.pop(context);
          onUnitSelected(unit, lessonIndex);
        },
      ),
    );
  }
}

class _LessonSelectionSheet extends StatefulWidget {
  const _LessonSelectionSheet({
    required this.unit,
    required this.onLessonSelected,
  });

  final StudyUnit unit;
  final void Function(int lessonIndex) onLessonSelected;

  @override
  State<_LessonSelectionSheet> createState() => _LessonSelectionSheetState();
}

class _LessonSelectionSheetState extends State<_LessonSelectionSheet> {
  int? _selectedLessonIndex;
  int _wordsToLearn = 5;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.baseWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return Column(
            children: [
              // Handle
              Container(
                margin: EdgeInsets.symmetric(vertical: 12.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: ColorManager.grey300,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),

              // Title
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.unit.title,
                      style: TextStyle(
                        fontSize: 22.sp.clamp(18, 24),
                        fontWeight: FontWeight.w700,
                        color: ColorManager.grey950,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Select a lesson and number of words',
                      style: TextStyle(
                        fontSize: 14.sp.clamp(12, 16),
                        fontWeight: FontWeight.w500,
                        color: ColorManager.grey500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              // Lessons list
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount: widget.unit.lessons.length,
                  itemBuilder: (context, index) {
                    final lesson = widget.unit.lessons[index];
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
                              width: 40.r,
                              height: 40.r,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? ColorManager.purpleHard
                                    : ColorManager.grey200,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Center(
                                child: Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    fontSize: 16.sp.clamp(14, 18),
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
                                      fontSize: 16.sp.clamp(14, 18),
                                      fontWeight: FontWeight.w600,
                                      color: ColorManager.grey950,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
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
                              Container(
                                padding: EdgeInsets.all(4.r),
                                decoration: const BoxDecoration(
                                  color: ColorManager.purpleHard,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.check_rounded,
                                  size: 16.r,
                                  color: Colors.white,
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Word count slider
              if (_selectedLessonIndex != null) _buildWordCountSelector(),

              // Start button
              Padding(
                padding: EdgeInsets.all(20.w),
                child: SafeArea(
                  top: false,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _selectedLessonIndex != null
                          ? () {
                              widget.onLessonSelected(_selectedLessonIndex!);
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.purpleHard,
                        disabledBackgroundColor: ColorManager.grey300,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
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
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildWordCountSelector() {
    final maxWords = _selectedLessonIndex != null
        ? widget.unit.lessons[_selectedLessonIndex!].words.length
        : 5;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
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
              divisions: maxWords - 1,
              onChanged: (value) {
                setState(() {
                  _wordsToLearn = value.round();
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '1 word',
                style: TextStyle(
                  fontSize: 12.sp.clamp(11, 14),
                  fontWeight: FontWeight.w500,
                  color: ColorManager.grey500,
                ),
              ),
              Text(
                '$maxWords words',
                style: TextStyle(
                  fontSize: 12.sp.clamp(11, 14),
                  fontWeight: FontWeight.w500,
                  color: ColorManager.grey500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
