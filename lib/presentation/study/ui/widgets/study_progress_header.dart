import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e4u_application/app/app.dart';
import 'package:e4u_application/presentation/study/domain/models/study_models.dart';

/// Header widget showing study session progress.
class StudyProgressHeader extends StatelessWidget {
  const StudyProgressHeader({
    super.key,
    required this.session,
    this.onClose,
  });

  final StudySession session;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: const BoxDecoration(
        color: ColorManager.baseWhite,
        border: Border(
          bottom: BorderSide(
            color: ColorManager.grey200,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Row(
              children: [
                // Close button
                GestureDetector(
                  onTap: onClose,
                  child: Container(
                    width: 40.r,
                    height: 40.r,
                    decoration: const BoxDecoration(
                      color: ColorManager.grey100,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      size: 22.r,
                      color: ColorManager.grey700,
                    ),
                  ),
                ),
                SizedBox(width: 16.w),

                // Progress bar
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _getPhaseLabel(),
                            style: TextStyle(
                              fontSize: 12.sp.clamp(11, 14),
                              fontWeight: FontWeight.w600,
                              color: ColorManager.grey500,
                            ),
                          ),
                          Text(
                            '${session.currentExerciseIndex + 1}/${session.totalExercises}',
                            style: TextStyle(
                              fontSize: 12.sp.clamp(11, 14),
                              fontWeight: FontWeight.w600,
                              color: ColorManager.purpleHard,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4.r),
                        child: LinearProgressIndicator(
                          value: session.progress,
                          backgroundColor: ColorManager.grey200,
                          valueColor: const AlwaysStoppedAnimation(
                            ColorManager.purpleHard,
                          ),
                          minHeight: 8.h,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16.w),

                // Stats
                _buildStatsChip(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getPhaseLabel() {
    switch (session.currentPhase) {
      case StudyPhase.contextualDiscovery:
        return 'DISCOVERY';
      case StudyPhase.mechanicDrill:
        return 'PRACTICE';
      case StudyPhase.microTaskOutput:
        return 'CHALLENGE';
      case StudyPhase.completed:
        return 'COMPLETED';
    }
  }

  Widget _buildStatsChip() {
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
            Icons.check_circle_rounded,
            size: 16.r,
            color: const Color(0xFF4CAF50),
          ),
          SizedBox(width: 4.w),
          Text(
            '${session.correctAnswers}',
            style: TextStyle(
              fontSize: 14.sp.clamp(12, 16),
              fontWeight: FontWeight.w600,
              color: ColorManager.grey950,
            ),
          ),
        ],
      ),
    );
  }
}
