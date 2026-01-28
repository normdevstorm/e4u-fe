import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e4u_application/app/app.dart';
import 'package:e4u_application/presentation/curriculum/domain/models/curriculum_model.dart';

/// Card widget for displaying a curriculum.
/// Highlights the current active curriculum and shows progress.
class CurriculumCard extends StatelessWidget {
  const CurriculumCard({
    super.key,
    required this.curriculum,
    required this.onTap,
  });

  final CurriculumModel curriculum;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bool isHighlighted = curriculum.isCurrent;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: ColorManager.baseWhite,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color:
                isHighlighted ? ColorManager.purpleHard : ColorManager.grey100,
            width: isHighlighted ? 2 : 1,
          ),
          boxShadow: isHighlighted
              ? [
                  BoxShadow(
                    color: ColorManager.purpleHard.withOpacity(0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with current badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (isHighlighted)
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: ColorManager.purpleHard,
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.play_arrow_rounded,
                          size: 14.r,
                          color: Colors.white,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Current',
                          style: TextStyle(
                            fontSize: 12.sp.clamp(11, 14),
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  const SizedBox.shrink(),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16.r,
                  color: ColorManager.grey400,
                ),
              ],
            ),
            SizedBox(height: isHighlighted ? 12.h : 4.h),

            // Title
            Text(
              curriculum.title,
              style: TextStyle(
                fontSize: 18.sp.clamp(16, 20),
                fontWeight: FontWeight.w700,
                color: ColorManager.grey950,
                height: 1.3,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 6.h),

            // Description
            Text(
              curriculum.description,
              style: TextStyle(
                fontSize: 14.sp.clamp(13, 16),
                fontWeight: FontWeight.w400,
                color: ColorManager.grey500,
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 12.h),

            // Meta info row
            Row(
              children: [
                _buildMetaItem(
                  icon: Icons.person_outline_rounded,
                  text: curriculum.author,
                ),
                SizedBox(width: 16.w),
                _buildMetaItem(
                  icon: Icons.library_books_outlined,
                  text: '${curriculum.lessonCount} lessons',
                ),
                SizedBox(width: 16.w),
                _buildMetaItem(
                  icon: Icons.access_time_rounded,
                  text: curriculum.totalDuration,
                ),
              ],
            ),

            // Progress bar (only if progress > 0)
            if (curriculum.progress > 0) ...[
              SizedBox(height: 16.h),
              _buildProgressBar(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMetaItem({
    required IconData icon,
    required String text,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16.r,
          color: ColorManager.grey400,
        ),
        SizedBox(width: 4.w),
        Flexible(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13.sp.clamp(12, 15),
              fontWeight: FontWeight.w500,
              color: ColorManager.grey500,
            ),
            overflow: TextOverflow.ellipsis,
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
              curriculum.progressPercentage,
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
            value: curriculum.progress,
            backgroundColor: ColorManager.grey100,
            valueColor:
                const AlwaysStoppedAnimation<Color>(ColorManager.purpleHard),
            minHeight: 6.h,
          ),
        ),
      ],
    );
  }
}
