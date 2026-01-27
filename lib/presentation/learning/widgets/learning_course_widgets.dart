import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e4u_application/app/app.dart';

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10.r,
      height: 10.r,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }
}

class _ProgressBarPair extends StatelessWidget {
  const _ProgressBarPair({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.backgroundFraction,
    required this.foregroundFraction,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final double backgroundFraction;
  final double foregroundFraction;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return Stack(
          children: [
            Container(
              height: 22.h.clamp(20, 28),
              width: width * backgroundFraction,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            Container(
              height: 22.h.clamp(20, 28),
              width: width * foregroundFraction,
              decoration: BoxDecoration(
                color: foregroundColor,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ],
        );
      },
    );
  }
}

class LearningModuleHeader extends StatelessWidget {
  const LearningModuleHeader({
    super.key,
    required this.label,
    required this.title,
    required this.isExpanded,
    required this.onTap,
  });

  final String label;
  final String title;
  final bool isExpanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: ColorManager.grey100,
              width: 1,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 13.sp.clamp(12, 15),
                      fontWeight: FontWeight.w500,
                      color: ColorManager.grey500,
                      letterSpacing: 0.3,
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Flexible(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 15.sp.clamp(14, 17),
                        fontWeight: FontWeight.w600,
                        color: ColorManager.grey950,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedRotation(
              turns: isExpanded ? 0.5 : 0,
              duration: const Duration(milliseconds: 200),
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 22.r,
                color: ColorManager.grey700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum LessonStatus { completed, live, locked }

class LearningLessonCard extends StatelessWidget {
  const LearningLessonCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.status,
    this.isLive = false,
  });

  final String title;
  final String subtitle;
  final LessonStatus status;
  final bool isLive;

  @override
  Widget build(BuildContext context) {
    final bool isHighlighted = status == LessonStatus.live;

    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: ColorManager.baseWhite,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: isHighlighted ? ColorManager.purpleHard : ColorManager.grey100,
          width: isHighlighted ? 1.5 : 1,
        ),
        boxShadow: isHighlighted
            ? [
                BoxShadow(
                  color: ColorManager.purpleHard.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 42.r,
                  height: 42.r,
                  decoration: const BoxDecoration(
                    color: ColorManager.grey50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person_rounded,
                    color: ColorManager.grey500,
                    size: 22.r,
                  ),
                ),
                SizedBox(width: 12.w),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 15.sp.clamp(14, 17),
                          fontWeight: FontWeight.w600,
                          color: ColorManager.grey950,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      if (isLive)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 3.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(237, 85, 84, 0.1),
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.circle,
                                size: 10.r,
                                color: ColorManager.errorColorLight,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                'Live',
                                style: TextStyle(
                                  fontSize: 13.sp.clamp(12, 15),
                                  fontWeight: FontWeight.w600,
                                  color: ColorManager.grey950,
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 13.sp.clamp(12, 15),
                            fontWeight: FontWeight.w500,
                            color: ColorManager.grey500,
                            height: 1.3,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          _buildStatusTrailing(),
        ],
      ),
    );
  }

  Widget _buildStatusTrailing() {
    switch (status) {
      case LessonStatus.completed:
        return CircleAvatar(
          radius: 18.r,
          backgroundColor: ColorManager.grey50,
          child: Icon(
            Icons.check_rounded,
            size: 20.r,
            color: ColorManager.grey700,
          ),
        );
      case LessonStatus.live:
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: ColorManager.purpleHard,
            borderRadius: BorderRadius.circular(100.r),
            border: Border.all(color: Colors.white.withOpacity(0.4)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.play_arrow_rounded,
                size: 16.r,
                color: Colors.white,
              ),
              SizedBox(width: 4.w),
              Text(
                'Join Now',
                style: TextStyle(
                  fontSize: 13.sp.clamp(12, 15),
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      case LessonStatus.locked:
        return CircleAvatar(
          radius: 18.r,
          backgroundColor: ColorManager.grey50,
          child: Icon(
            Icons.lock_rounded,
            size: 18.r,
            color: ColorManager.grey400,
          ),
        );
    }
  }
}

class LearningProgressCard extends StatelessWidget {
  const LearningProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: ColorManager.baseWhite,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Learning Progress',
                      style: TextStyle(
                        fontSize: 17.sp.clamp(16, 20),
                        fontWeight: FontWeight.w600,
                        color: ColorManager.grey950,
                        height: 1.3,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Weekly report, 01 May - Today',
                      style: TextStyle(
                        fontSize: 13.sp.clamp(12, 15),
                        fontWeight: FontWeight.w400,
                        color: ColorManager.grey500,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const _LegendDot(color: ColorManager.grey400),
                      SizedBox(width: 6.w),
                      Text(
                        'Last Week',
                        style: TextStyle(
                          fontSize: 12.sp.clamp(11, 14),
                          fontWeight: FontWeight.w500,
                          color: ColorManager.grey950,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      const _LegendDot(color: ColorManager.purpleHard),
                      SizedBox(width: 6.w),
                      Text(
                        'This Week',
                        style: TextStyle(
                          fontSize: 12.sp.clamp(11, 14),
                          fontWeight: FontWeight.w500,
                          color: ColorManager.grey950,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: ColorManager.grey50,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Progress',
                  style: TextStyle(
                    fontSize: 13.sp.clamp(12, 15),
                    fontWeight: FontWeight.w600,
                    color: ColorManager.grey950,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: 8.h),
                const _ProgressBarPair(
                  backgroundColor: ColorManager.extraYellow,
                  foregroundColor: ColorManager.purpleHard,
                  backgroundFraction: 1.0,
                  foregroundFraction: 0.7,
                ),
                SizedBox(height: 14.h),
                Text(
                  'Average this course members',
                  style: TextStyle(
                    fontSize: 13.sp.clamp(12, 15),
                    fontWeight: FontWeight.w600,
                    color: ColorManager.grey950,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: 8.h),
                const _ProgressBarPair(
                  backgroundColor: ColorManager.extraYellow,
                  foregroundColor: ColorManager.purpleHard,
                  backgroundFraction: 0.7,
                  foregroundFraction: 0.5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
