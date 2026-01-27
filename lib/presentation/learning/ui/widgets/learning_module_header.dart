import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e4u_application/app/app.dart';

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
