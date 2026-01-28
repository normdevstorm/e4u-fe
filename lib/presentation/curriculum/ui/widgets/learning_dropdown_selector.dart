import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e4u_application/app/app.dart';

/// A reusable dropdown selector widget with pill-style design.
/// Used for filtering content like curriculums, chapters, categories, etc.
class LearningDropdownSelector extends StatelessWidget {
  const LearningDropdownSelector({
    super.key,
    required this.selectedValue,
    required this.onTap,
  });

  /// The currently selected value to display
  final String selectedValue;

  /// Callback when the selector is tapped
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
              selectedValue,
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
    );
  }
}
