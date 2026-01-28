import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e4u_application/app/app.dart';
import 'package:e4u_application/presentation/curriculum/ui/controllers/learning_course_controller.dart';
import 'package:e4u_application/presentation/curriculum/ui/widgets/curriculum_card.dart';
import 'package:e4u_application/presentation/curriculum/ui/widgets/learning_dropdown_selector.dart';

/// Mobile screen for displaying all curriculums.
/// Shows curriculum cards with current curriculum highlighted and on top.
/// Clicking a card navigates to StudyLessonSelectionScreen to show lessons.
class LearningCourseMobileScreen extends StatefulWidget {
  const LearningCourseMobileScreen({
    super.key,
    required this.controller,
    required this.onCurriculumTap,
  });

  final LearningCourseController controller;
  final void Function(String curriculumId) onCurriculumTap;

  @override
  State<LearningCourseMobileScreen> createState() =>
      _LearningCourseMobileScreenState();
}

class _LearningCourseMobileScreenState
    extends State<LearningCourseMobileScreen> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onControllerChange);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChange);
    super.dispose();
  }

  void _onControllerChange() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.grey50,
      body: SafeArea(
        child: Column(
          children: [
            _buildToolbar(context),
            SizedBox(height: 8.h),
            _buildHeader(context),
            SizedBox(height: 16.h),
            Expanded(
              child: _buildCurriculumList(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolbar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).maybePop(),
                  child: Container(
                    width: 40.r,
                    height: 40.r,
                    decoration: const BoxDecoration(
                      color: ColorManager.baseWhite,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18.r,
                        color: ColorManager.grey950,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'MY CURRICULUMS',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 17.sp.clamp(16, 20),
                          fontWeight: FontWeight.w600,
                          color: ColorManager.grey950,
                          height: 1.25,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '${widget.controller.curriculums.length} curriculums available',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 13.sp.clamp(12, 15),
                          fontWeight: FontWeight.w500,
                          color: ColorManager.grey500,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              // TODO: Implement more options menu
            },
            child: Container(
              width: 40.r,
              height: 40.r,
              decoration: const BoxDecoration(
                color: ColorManager.baseWhite,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.more_horiz_rounded,
                  size: 22.r,
                  color: ColorManager.grey950,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'ALL CURRICULUMS',
            style: TextStyle(
              fontSize: 14.sp.clamp(13, 16),
              fontWeight: FontWeight.w700,
              color: ColorManager.grey950,
              letterSpacing: 0.5,
            ),
          ),
          LearningDropdownSelector(
            selectedValue: widget.controller.selectedCurriculumFilter,
            onTap: () async {
              await widget.controller.showCurriculumFilterDropdown(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCurriculumList(BuildContext context) {
    final curriculums = widget.controller.sortedCurriculums;

    if (widget.controller.isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: ColorManager.purpleHard,
        ),
      );
    }

    if (curriculums.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.library_books_outlined,
              size: 64.r,
              color: ColorManager.grey300,
            ),
            SizedBox(height: 16.h),
            Text(
              'No curriculums available',
              style: TextStyle(
                fontSize: 16.sp.clamp(15, 18),
                fontWeight: FontWeight.w500,
                color: ColorManager.grey500,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: widget.controller.refreshCurriculums,
      color: ColorManager.purpleHard,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        itemCount: curriculums.length,
        separatorBuilder: (context, index) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          final curriculum = curriculums[index];
          return CurriculumCard(
            curriculum: curriculum,
            onTap: () => widget.onCurriculumTap(curriculum.id),
          );
        },
      ),
    );
  }
}
