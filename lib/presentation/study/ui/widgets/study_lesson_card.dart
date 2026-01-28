import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e4u_application/app/app.dart';
import 'package:e4u_application/presentation/study/domain/models/study_models.dart';

/// Card widget displaying a lesson for selection.
class StudyLessonCard extends StatelessWidget {
  const StudyLessonCard({
    super.key,
    required this.lesson,
    required this.onTap,
    this.isSelected = false,
  });

  final StudyLesson lesson;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: lesson.isLocked ? null : onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: lesson.isLocked
              ? ColorManager.grey100
              : (isSelected
                  ? ColorManager.purpleLight
                  : ColorManager.baseWhite),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? ColorManager.purpleHard : ColorManager.grey200,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Lesson icon/thumbnail
                Container(
                  width: 48.r,
                  height: 48.r,
                  decoration: BoxDecoration(
                    color: lesson.isLocked
                        ? ColorManager.grey200
                        : ColorManager.purpleLight,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    lesson.isLocked
                        ? Icons.lock_rounded
                        : Icons.menu_book_rounded,
                    size: 24.r,
                    color: lesson.isLocked
                        ? ColorManager.grey400
                        : ColorManager.purpleHard,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lesson.title,
                        style: TextStyle(
                          fontSize: 16.sp.clamp(14, 18),
                          fontWeight: FontWeight.w600,
                          color: lesson.isLocked
                              ? ColorManager.grey400
                              : ColorManager.grey950,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        lesson.description,
                        style: TextStyle(
                          fontSize: 13.sp.clamp(12, 15),
                          fontWeight: FontWeight.w400,
                          color: ColorManager.grey500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
            SizedBox(height: 12.h),
            // Lesson info
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
                if (lesson.estimatedMinutes != null) ...[
                  SizedBox(width: 12.w),
                  _buildInfoChip(
                    Icons.timer_outlined,
                    '${lesson.estimatedMinutes} min',
                  ),
                ],
              ],
            ),
            // Progress bar (if applicable)
            if (lesson.progress > 0 && !lesson.isLocked) ...[
              SizedBox(height: 12.h),
              _buildProgressBar(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14.r,
          color: ColorManager.grey500,
        ),
        SizedBox(width: 4.w),
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

  Widget _buildProgressBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Progress',
              style: TextStyle(
                fontSize: 12.sp.clamp(11, 14),
                fontWeight: FontWeight.w500,
                color: ColorManager.grey500,
              ),
            ),
            Text(
              '${(lesson.progress * 100).toInt()}%',
              style: TextStyle(
                fontSize: 12.sp.clamp(11, 14),
                fontWeight: FontWeight.w600,
                color: ColorManager.purpleHard,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(4.r),
          child: LinearProgressIndicator(
            value: lesson.progress,
            backgroundColor: ColorManager.grey200,
            valueColor: const AlwaysStoppedAnimation(ColorManager.purpleHard),
            minHeight: 6.h,
          ),
        ),
      ],
    );
  }
}
