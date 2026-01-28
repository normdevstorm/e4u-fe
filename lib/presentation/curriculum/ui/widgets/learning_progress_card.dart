import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e4u_application/app/app.dart';

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
