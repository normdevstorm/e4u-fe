import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e4u_application/app/app.dart';

enum LessonStatus { completed, live, locked }

class LearningLessonCard extends StatelessWidget {
  const LearningLessonCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.status,
    this.isLive = false,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final LessonStatus status;
  final bool isLive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bool isHighlighted = status == LessonStatus.live;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: ColorManager.baseWhite,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color:
                isHighlighted ? ColorManager.purpleHard : ColorManager.grey100,
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
