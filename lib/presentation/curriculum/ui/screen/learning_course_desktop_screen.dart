import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e4u_application/app/app.dart';
import 'package:e4u_application/presentation/curriculum/ui/controllers/learning_course_controller.dart';
import 'package:e4u_application/presentation/curriculum/ui/widgets/curriculum_card.dart';

/// Desktop screen for displaying all curriculums.
/// Shows curriculum cards in a grid layout with current curriculum highlighted.
/// Clicking a card navigates to StudyLessonSelectionScreen to show lessons.
class LearningCourseDesktopScreen extends StatefulWidget {
  const LearningCourseDesktopScreen({
    super.key,
    required this.controller,
    required this.onCurriculumTap,
  });

  final LearningCourseController controller;
  final void Function(String curriculumId) onCurriculumTap;

  @override
  State<LearningCourseDesktopScreen> createState() =>
      _LearningCourseDesktopScreenState();
}

class _LearningCourseDesktopScreenState
    extends State<LearningCourseDesktopScreen> {
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
      body: Column(
        children: [
          _buildToolbar(context),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 24.h),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 1400.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(context),
                      SizedBox(height: 24.h),
                      _buildCurriculumGrid(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolbar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 16.h),
      decoration: const BoxDecoration(
        color: ColorManager.baseWhite,
        border: Border(
          bottom: BorderSide(
            color: ColorManager.grey200,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).maybePop(),
                child: Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: const BoxDecoration(
                    color: ColorManager.grey50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 20.sp,
                    color: ColorManager.grey900,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MY CURRICULUMS',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.grey950,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${widget.controller.curriculums.length} curriculums available',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorManager.grey500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              // TODO: Implement more options menu
            },
            child: Container(
              width: 48.w,
              height: 48.h,
              decoration: const BoxDecoration(
                color: ColorManager.grey50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.more_horiz_rounded,
                size: 20.sp,
                color: ColorManager.grey900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'ALL CURRICULUMS',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            color: ColorManager.grey950,
          ),
        ),
        InkWell(
          onTap: () async {
            await widget.controller.showCurriculumFilterDropdown(context);
          },
          borderRadius: BorderRadius.circular(100.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: ColorManager.baseWhite,
              borderRadius: BorderRadius.circular(100.r),
              border: Border.all(color: ColorManager.grey100),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.controller.selectedCurriculumFilter,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.grey950,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 20.sp,
                  color: ColorManager.grey800,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCurriculumGrid(BuildContext context) {
    final curriculums = widget.controller.sortedCurriculums;

    if (widget.controller.isLoading) {
      return SizedBox(
        height: 300.h,
        child: const Center(
          child: CircularProgressIndicator(
            color: ColorManager.purpleHard,
          ),
        ),
      );
    }

    if (curriculums.isEmpty) {
      return SizedBox(
        height: 300.h,
        child: Center(
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
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorManager.grey500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate number of columns based on available width
        final crossAxisCount = constraints.maxWidth > 1200
            ? 3
            : constraints.maxWidth > 800
                ? 2
                : 1;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 20.w,
            mainAxisSpacing: 20.h,
            childAspectRatio: 1.4,
          ),
          itemCount: curriculums.length,
          itemBuilder: (context, index) {
            final curriculum = curriculums[index];
            return CurriculumCard(
              curriculum: curriculum,
              onTap: () => widget.onCurriculumTap(curriculum.id),
            );
          },
        );
      },
    );
  }
}
