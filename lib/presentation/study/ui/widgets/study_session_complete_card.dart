import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e4u_application/app/app.dart';
import 'package:e4u_application/presentation/study/domain/models/study_models.dart';

/// Card displayed when a study session is complete.
class StudySessionCompleteCard extends StatelessWidget {
  const StudySessionCompleteCard({
    super.key,
    required this.session,
    required this.onContinue,
    required this.onReview,
  });

  final StudySession session;
  final VoidCallback onContinue;
  final VoidCallback onReview;

  @override
  Widget build(BuildContext context) {
    final accuracyPercent = (session.accuracy * 100).toInt();
    final totalAnswers = session.correctAnswers + session.incorrectAnswers;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: ColorManager.baseWhite,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Success illustration
          _buildSuccessIllustration(),
          SizedBox(height: 24.h),

          // Title
          Text(
            'Session Complete!',
            style: TextStyle(
              fontSize: 28.sp.clamp(24, 32),
              fontWeight: FontWeight.w700,
              color: ColorManager.grey950,
            ),
          ),
          SizedBox(height: 8.h),

          Text(
            'Great job learning ${session.wordsToLearn} words',
            style: TextStyle(
              fontSize: 16.sp.clamp(14, 18),
              fontWeight: FontWeight.w500,
              color: ColorManager.grey500,
            ),
          ),
          SizedBox(height: 32.h),

          // Stats grid
          _buildStatsGrid(accuracyPercent, totalAnswers),
          SizedBox(height: 32.h),

          // Words learned
          _buildWordsLearned(),
          SizedBox(height: 32.h),

          // Action buttons
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildSuccessIllustration() {
    return Container(
      width: 120.r,
      height: 120.r,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF9C27B0),
            ColorManager.purpleHard,
          ],
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: ColorManager.purpleHard.withOpacity(0.4),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Icon(
        Icons.celebration_rounded,
        size: 56.r,
        color: Colors.white,
      ),
    );
  }

  Widget _buildStatsGrid(int accuracyPercent, int totalAnswers) {
    return Row(
      children: [
        Expanded(
          child: _buildStatItem(
            icon: Icons.check_circle_rounded,
            iconColor: const Color(0xFF4CAF50),
            label: 'Correct',
            value: '${session.correctAnswers}',
          ),
        ),
        Container(
          width: 1,
          height: 60.h,
          color: ColorManager.grey200,
        ),
        Expanded(
          child: _buildStatItem(
            icon: Icons.cancel_rounded,
            iconColor: const Color(0xFFF44336),
            label: 'Incorrect',
            value: '${session.incorrectAnswers}',
          ),
        ),
        Container(
          width: 1,
          height: 60.h,
          color: ColorManager.grey200,
        ),
        Expanded(
          child: _buildStatItem(
            icon: Icons.percent_rounded,
            iconColor: ColorManager.purpleHard,
            label: 'Accuracy',
            value: '$accuracyPercent%',
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          size: 28.r,
          color: iconColor,
        ),
        SizedBox(height: 8.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 24.sp.clamp(20, 28),
            fontWeight: FontWeight.w700,
            color: ColorManager.grey950,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp.clamp(11, 14),
            fontWeight: FontWeight.w500,
            color: ColorManager.grey500,
          ),
        ),
      ],
    );
  }

  Widget _buildWordsLearned() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.grey50,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Words Learned',
                style: TextStyle(
                  fontSize: 14.sp.clamp(12, 16),
                  fontWeight: FontWeight.w600,
                  color: ColorManager.grey700,
                ),
              ),
              Text(
                '${session.words.length} words',
                style: TextStyle(
                  fontSize: 14.sp.clamp(12, 16),
                  fontWeight: FontWeight.w600,
                  color: ColorManager.purpleHard,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: session.words.take(6).map((word) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: ColorManager.baseWhite,
                  borderRadius: BorderRadius.circular(100.r),
                  border: Border.all(color: ColorManager.grey200),
                ),
                child: Text(
                  word.english,
                  style: TextStyle(
                    fontSize: 13.sp.clamp(12, 15),
                    fontWeight: FontWeight.w500,
                    color: ColorManager.grey800,
                  ),
                ),
              );
            }).toList(),
          ),
          if (session.words.length > 6) ...[
            SizedBox(height: 8.h),
            Text(
              '+${session.words.length - 6} more',
              style: TextStyle(
                fontSize: 12.sp.clamp(11, 14),
                fontWeight: FontWeight.w500,
                color: ColorManager.grey500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onContinue,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.purpleHard,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
            ),
            child: Text(
              'Continue Learning',
              style: TextStyle(
                fontSize: 16.sp.clamp(14, 18),
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: onReview,
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              side: const BorderSide(color: ColorManager.grey300),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Review Words',
              style: TextStyle(
                fontSize: 16.sp.clamp(14, 18),
                fontWeight: FontWeight.w600,
                color: ColorManager.grey700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
