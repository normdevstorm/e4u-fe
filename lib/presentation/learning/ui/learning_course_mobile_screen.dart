import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e4u_application/app/app.dart';
import 'package:e4u_application/presentation/learning/controllers/learning_course_controller.dart';
import 'package:e4u_application/presentation/learning/widgets/learning_course_widgets.dart';

class LearningCourseMobileScreen extends StatefulWidget {
  const LearningCourseMobileScreen({
    super.key,
    required this.controller,
  });

  final LearningCourseController controller;

  @override
  State<LearningCourseMobileScreen> createState() =>
      _LearningCourseMobileScreenState();
}

class _LearningCourseMobileScreenState
    extends State<LearningCourseMobileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.grey50,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildToolbar(context),
              _buildTabs(context),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: const LearningProgressCard(),
              ),
              SizedBox(height: 16.h),
              _buildLessonsHeader(context),
              SizedBox(height: 8.h),
              _buildLessonsModules(context),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToolbar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).maybePop(),
                  child: Container(
                    width: 64.r,
                    height: 64.r,
                    decoration: const BoxDecoration(
                      color: ColorManager.baseWhite,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.close_rounded,
                        size: 34.r,
                        color: ColorManager.grey950,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'CURRICULUM TITLE',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w600,
                          color: ColorManager.grey950,
                          height: 1.25,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'By E4U AI',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 18.sp,
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
          Container(
            width: 64.r,
            height: 64.r,
            decoration: const BoxDecoration(
              color: ColorManager.baseWhite,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.more_horiz_rounded,
                size: 34.r,
                color: ColorManager.grey950,
              ),
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
        border: Border(
          bottom: BorderSide(
            color: ColorManager.grey200,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final bool isSelected = index == widget.controller.selectedTabIndex;
          return Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  widget.controller.setSelectedTab(index);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected
                          ? ColorManager.purpleHard
                          : Colors.transparent,
                      width: 2.5,
                    ),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Center(
                  child: Text(
                    tabs[index],
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 18.sp,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected
                          ? ColorManager.purpleHard
                          : ColorManager.grey500,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildLessonsHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'LESSONS',
            style: TextStyle(
              fontSize: 18.sp.clamp(17, 22),
              fontWeight: FontWeight.w700,
              color: ColorManager.grey950,
              letterSpacing: 0.5,
            ),
          ),
          InkWell(
            onTap: () async {
              await widget.controller.showChapterDropdown(context);
              setState(() {}); // Refresh to show updated selected chapter
            },
            borderRadius: BorderRadius.circular(100.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: ColorManager.baseWhite,
                borderRadius: BorderRadius.circular(100.r),
                border: Border.all(color: ColorManager.grey200),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.controller.selectedChapter,
                    style: TextStyle(
                      fontSize: 14.sp.clamp(13, 16),
                      fontWeight: FontWeight.w600,
                      color: ColorManager.grey950,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 20.r,
                    color: ColorManager.grey800,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonsModules(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.w),
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
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Text(
                  'No lessons available yet',
                  style: TextStyle(
                    fontSize: 14.sp.clamp(13, 16),
                    color: ColorManager.grey500,
                    height: 1.4,
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
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Text(
                  'No lessons available yet',
                  style: TextStyle(
                    fontSize: 14.sp.clamp(13, 16),
                    color: ColorManager.grey500,
                    height: 1.4,
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
              SizedBox(height: 12.h),
              const LearningLessonCard(
                title: 'Rules of Bootcamp',
                subtitle: '14 May • 10 mins',
                status: LessonStatus.completed,
              ),
              SizedBox(height: 8.h),
              const LearningLessonCard(
                title: 'Principles & Elements',
                subtitle: 'Live',
                isLive: true,
                status: LessonStatus.live,
              ),
              SizedBox(height: 8.h),
              const LearningLessonCard(
                title: 'Concept Generate',
                subtitle: '18 May',
                status: LessonStatus.locked,
              ),
              SizedBox(height: 8.h),
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
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Text(
                  'No lessons available yet',
                  style: TextStyle(
                    fontSize: 14.sp.clamp(13, 16),
                    color: ColorManager.grey500,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
