import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e4u_application/app/app.dart';
import 'package:e4u_application/presentation/study/domain/models/study_models.dart';
import 'package:e4u_application/presentation/study/ui/controllers/study_session_controller.dart';
import 'package:e4u_application/presentation/study/ui/widgets/study_widgets.dart';

/// Desktop screen for lesson selection.
class StudyLessonSelectionDesktopScreen extends StatefulWidget {
  const StudyLessonSelectionDesktopScreen({
    super.key,
    required this.controller,
    required this.onLessonSelected,
    required this.onBack,
  });

  final StudySessionController controller;
  final void Function(StudyLesson lesson, int partIndex) onLessonSelected;
  final VoidCallback onBack;

  @override
  State<StudyLessonSelectionDesktopScreen> createState() =>
      _StudyLessonSelectionDesktopScreenState();
}

class _StudyLessonSelectionDesktopScreenState
    extends State<StudyLessonSelectionDesktopScreen> {
  int? _selectedPartIndex;
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
              // Left side: Header and lesson list
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    _buildHeader(),
                    Expanded(
                      child: _buildLessonList(),
                    ),
                  ],
                ),
              ),

              // Right side: Lesson details
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
                child: widget.controller.selectedLesson != null
                    ? _buildLessonDetails(widget.controller.selectedLesson!)
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
                    'Choose a Lesson',
                    style: TextStyle(
                      fontSize: 28.sp.clamp(24, 32),
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Select a lesson to start learning vocabulary',
                    style: TextStyle(
                      fontSize: 16.sp.clamp(14, 18),
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.8),
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

  Widget _buildLessonList() {
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
      itemCount: widget.controller.lessons.length,
      itemBuilder: (context, index) {
        final lesson = widget.controller.lessons[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: StudyLessonCard(
            lesson: lesson,
            isSelected: widget.controller.selectedLesson?.id == lesson.id,
            onTap: () {
              widget.controller.selectLessonById(lesson.id);
              setState(() {
                _selectedPartIndex = null;
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
            'Select a lesson',
            style: TextStyle(
              fontSize: 18.sp.clamp(16, 20),
              fontWeight: FontWeight.w600,
              color: ColorManager.grey500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Choose a lesson from the list\nto view details',
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

  Widget _buildLessonDetails(StudyLesson lesson) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Lesson title
        Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lesson.title,
                style: TextStyle(
                  fontSize: 24.sp.clamp(20, 28),
                  fontWeight: FontWeight.w700,
                  color: ColorManager.grey950,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                lesson.description,
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
                    '${lesson.totalParts} parts',
                  ),
                  SizedBox(width: 12.w),
                  _buildInfoChip(
                    Icons.text_fields_rounded,
                    '${lesson.totalWords} words',
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(height: 1, color: ColorManager.grey200),

        // Parts selection
        Padding(
          padding: EdgeInsets.all(24.w),
          child: Text(
            'Select a Part',
            style: TextStyle(
              fontSize: 16.sp.clamp(14, 18),
              fontWeight: FontWeight.w600,
              color: ColorManager.grey700,
            ),
          ),
        ),

        // Parts list
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            itemCount: lesson.parts.length,
            itemBuilder: (context, index) {
              final part = lesson.parts[index];
              final isSelected = _selectedPartIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedPartIndex = index;
                    _wordsToLearn = part.words.length.clamp(1, 5);
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
                              'Part ${index + 1}',
                              style: TextStyle(
                                fontSize: 15.sp.clamp(14, 17),
                                fontWeight: FontWeight.w600,
                                color: ColorManager.grey950,
                              ),
                            ),
                            Text(
                              '${part.words.length} words',
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
        if (_selectedPartIndex != null) _buildWordCountSelector(lesson),

        // Start button
        Padding(
          padding: EdgeInsets.all(24.w),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _selectedPartIndex != null
                  ? () {
                      widget.onLessonSelected(lesson, _selectedPartIndex!);
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

  Widget _buildWordCountSelector(StudyLesson lesson) {
    final maxWords = _selectedPartIndex != null
        ? lesson.parts[_selectedPartIndex!].words.length
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
}
