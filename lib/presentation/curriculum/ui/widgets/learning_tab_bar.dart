import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e4u_application/app/app.dart';

/// A reusable tab bar widget for learning screens.
/// Used in both mobile and desktop views for consistent navigation.
class LearningTabBar extends StatelessWidget {
  const LearningTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
    this.isDesktop = false,
    this.horizontalPadding,
  });

  /// List of tab labels to display
  final List<String> tabs;

  /// Currently selected tab index
  final int selectedIndex;

  /// Callback when a tab is selected
  final ValueChanged<int> onTabSelected;

  /// Whether to use desktop layout (inline tabs with spacing)
  final bool isDesktop;

  /// Optional horizontal padding for the tab bar
  final double? horizontalPadding;

  @override
  Widget build(BuildContext context) {
    if (isDesktop) {
      return _buildDesktopTabs();
    }
    return _buildMobileTabs();
  }

  Widget _buildMobileTabs() {
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
          final bool isSelected = index == selectedIndex;
          return Expanded(
            child: InkWell(
              onTap: () => onTabSelected(index),
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected
                          ? ColorManager.purpleHard
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Center(
                  child: Text(
                    tabs[index],
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14.sp.clamp(13, 16),
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

  Widget _buildDesktopTabs() {
    return Container(
      decoration: const BoxDecoration(
        color: ColorManager.baseWhite,
        border: Border(
          bottom: BorderSide(
            color: ColorManager.grey200,
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 40.w),
        child: Row(
          children: List.generate(tabs.length, (index) {
            final bool isSelected = index == selectedIndex;
            return Padding(
              padding: EdgeInsets.only(right: 48.w),
              child: InkWell(
                onTap: () => onTabSelected(index),
                splashFactory: NoSplash.splashFactory,
                highlightColor: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 16.h, top: 8.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        tabs[index],
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: isSelected
                              ? ColorManager.purpleHard
                              : ColorManager.grey500,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      if (isSelected)
                        Container(
                          height: 2.h,
                          width: 60.w,
                          color: ColorManager.purpleHard,
                        )
                      else
                        SizedBox(height: 2.h),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
