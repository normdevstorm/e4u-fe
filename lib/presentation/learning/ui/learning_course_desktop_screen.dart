import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e4u_application/app/app.dart';
import 'package:e4u_application/presentation/learning/controllers/learning_course_controller.dart';
import 'package:e4u_application/presentation/learning/widgets/learning_course_widgets.dart';

class LearningCourseDesktopScreen extends StatefulWidget {
  const LearningCourseDesktopScreen({
    super.key,
    required this.controller,
  });

  final LearningCourseController controller;

  @override
  State<LearningCourseDesktopScreen> createState() =>
      _LearningCourseDesktopScreenState();
}

class _LearningCourseDesktopScreenState
    extends State<LearningCourseDesktopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.grey50,
      body: Column(
        children: [
          _buildToolbar(context),
          _buildTabs(context),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 24.h),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 1400.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Two-column layout: Progress on left, Lessons on right
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left column - Progress Card
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: EdgeInsets.only(right: 24.w),
                              child: const LearningProgressCard(),
                            ),
                          ),
                          // Right column - Lessons
                          Expanded(
                            flex: 6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLessonsHeader(context),
                                SizedBox(height: 16.h),
                                _buildLessonsModules(context),
                              ],
                            ),
                          ),
                        ],
                      ),
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
              Container(
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
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CURRICULUM TITLE',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.grey950,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'By E4U AI',
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
          Container(
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
        ],
      ),
    );
  }

  Widget _buildTabs(BuildContext context) {
    const tabs = ['Dashboard', 'Notes', 'Resources'];

    return Container(
      decoration: const BoxDecoration(
        color: ColorManager.baseWhite,
        border: Border(
          bottom: BorderSide(
            color: ColorManager.grey200,
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Row(
          children: List.generate(tabs.length, (index) {
            final bool isSelected = index == widget.controller.selectedTabIndex;
            return Padding(
              padding: EdgeInsets.only(right: 48.w),
              child: InkWell(
                onTap: () {
                  setState(() {
                    widget.controller.setSelectedTab(index);
                  });
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: 16.h, top: 8.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        tabs[index],
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: isSelected
                              ? ColorManager.purpleHard
                              : ColorManager.grey500,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      if (isSelected)
                        Container(
                          height: 2.h,
                          width: 60.w,
                          color: ColorManager.purpleHard,
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildLessonsHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'LESSONS',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            color: ColorManager.grey950,
          ),
        ),
        InkWell(
          onTap: () async {
            await widget.controller.showChapterDropdown(context);
            setState(() {}); // Refresh to show updated selected chapter
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
                  widget.controller.selectedChapter,
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

  Widget _buildLessonsModules(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: ColorManager.baseWhite,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          LearningModuleHeader(
            label: 'MODULE 1',
            title: 'Beginning & Basic',
            isExpanded: widget.controller.moduleExpandedState[0] ?? false,
            onTap: () {
              setState(() {
                widget.controller.toggleModule(0);
              });
            },
          ),
          if (widget.controller.moduleExpandedState[0] == true) ...[
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Text(
                'No lessons available yet',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: ColorManager.grey500,
                ),
              ),
            ),
          ],
          LearningModuleHeader(
            label: 'MODULE 2',
            title: 'Deep Dive',
            isExpanded: widget.controller.moduleExpandedState[1] ?? false,
            onTap: () {
              setState(() {
                widget.controller.toggleModule(1);
              });
            },
          ),
          if (widget.controller.moduleExpandedState[1] == true) ...[
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Text(
                'No lessons available yet',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: ColorManager.grey500,
                ),
              ),
            ),
          ],
          SizedBox(height: 8.h),
          LearningModuleHeader(
            label: 'MODULE 3',
            title: 'Bootcamp & Practical',
            isExpanded: widget.controller.moduleExpandedState[2] ?? false,
            onTap: () {
              setState(() {
                widget.controller.toggleModule(2);
              });
            },
          ),
          if (widget.controller.moduleExpandedState[2] == true) ...[
            SizedBox(height: 16.h),
            const LearningLessonCard(
              title: 'Rules of Bootcamp',
              subtitle: '14 May • 10 mins',
              status: LessonStatus.completed,
            ),
            SizedBox(height: 12.h),
            const LearningLessonCard(
              title: 'Principles & Elements',
              subtitle: 'Live',
              isLive: true,
              status: LessonStatus.live,
            ),
            SizedBox(height: 12.h),
            const LearningLessonCard(
              title: 'Concept Generate',
              subtitle: '18 May',
              status: LessonStatus.locked,
            ),
            SizedBox(height: 12.h),
            const LearningLessonCard(
              title: 'Identifying Grammar',
              subtitle: '20 May',
              status: LessonStatus.locked,
            ),
          ],
          SizedBox(height: 12.h),
          LearningModuleHeader(
            label: 'MODULE 4',
            title: 'Ending',
            isExpanded: widget.controller.moduleExpandedState[3] ?? false,
            onTap: () {
              setState(() {
                widget.controller.toggleModule(3);
              });
            },
          ),
          if (widget.controller.moduleExpandedState[3] == true) ...[
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Text(
                'No lessons available yet',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: ColorManager.grey500,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
