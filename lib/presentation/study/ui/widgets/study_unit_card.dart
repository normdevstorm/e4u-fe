import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e4u_application/app/app.dart';
import 'package:e4u_application/presentation/study/domain/models/study_models.dart';

/// Card widget displaying a unit for selection.
class StudyUnitCard extends StatelessWidget {
  const StudyUnitCard({
    super.key,
    required this.unit,
    required this.onTap,
    this.isSelected = false,
  });

  final StudyUnit unit;
  final VoidCallback onTap;
  final bool isSelected;

  /// Show bottom sheet with words preview
  void _showWordsPreview(BuildContext context) {
    // Collect all words from all lessons
    final allWords = unit.lessons.expand((lesson) => lesson.words).toList();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _WordsPreviewBottomSheet(
        unitTitle: unit.title,
        words: allWords,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: unit.isLocked ? null : onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: unit.isLocked
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
                // Unit icon/thumbnail
                Container(
                  width: 48.r,
                  height: 48.r,
                  decoration: BoxDecoration(
                    color: unit.isLocked
                        ? ColorManager.grey200
                        : ColorManager.purpleLight,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    unit.isLocked
                        ? Icons.lock_rounded
                        : Icons.menu_book_rounded,
                    size: 24.r,
                    color: unit.isLocked
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
                        unit.title,
                        style: TextStyle(
                          fontSize: 16.sp.clamp(14, 18),
                          fontWeight: FontWeight.w600,
                          color: unit.isLocked
                              ? ColorManager.grey400
                              : ColorManager.grey950,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        unit.description,
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
            // Unit info
            Row(
              children: [
                _buildInfoChip(
                  Icons.layers_rounded,
                  '${unit.totalLessons} lessons',
                ),
                SizedBox(width: 12.w),
                // Words count with preview button
                _buildWordsPreviewChip(context),
                if (unit.estimatedMinutes != null) ...[
                  SizedBox(width: 12.w),
                  _buildInfoChip(
                    Icons.timer_outlined,
                    '${unit.estimatedMinutes} min',
                  ),
                ],
              ],
            ),
            // Progress bar (if applicable)
            if (unit.progress > 0 && !unit.isLocked) ...[
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

  /// Build words count chip with preview button
  Widget _buildWordsPreviewChip(BuildContext context) {
    return GestureDetector(
      onTap: unit.isLocked ? null : () => _showWordsPreview(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: unit.isLocked
              ? ColorManager.grey200
              : ColorManager.purpleLight.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: unit.isLocked
                ? ColorManager.grey300
                : ColorManager.purpleHard.withOpacity(0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.text_fields_rounded,
              size: 14.r,
              color: unit.isLocked
                  ? ColorManager.grey400
                  : ColorManager.purpleHard,
            ),
            SizedBox(width: 4.w),
            Text(
              '${unit.totalWords} words',
              style: TextStyle(
                fontSize: 12.sp.clamp(11, 14),
                fontWeight: FontWeight.w500,
                color: unit.isLocked
                    ? ColorManager.grey400
                    : ColorManager.purpleHard,
              ),
            ),
            if (!unit.isLocked) ...[
              SizedBox(width: 4.w),
              Icon(
                Icons.visibility_outlined,
                size: 12.r,
                color: ColorManager.purpleHard,
              ),
            ],
          ],
        ),
      ),
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
              '${(unit.progress * 100).toInt()}%',
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
            value: unit.progress,
            backgroundColor: ColorManager.grey200,
            valueColor: const AlwaysStoppedAnimation(ColorManager.purpleHard),
            minHeight: 6.h,
          ),
        ),
      ],
    );
  }
}

/// Bottom sheet widget to preview words in a unit
class _WordsPreviewBottomSheet extends StatelessWidget {
  const _WordsPreviewBottomSheet({
    required this.unitTitle,
    required this.words,
  });

  final String unitTitle;
  final List<StudyWord> words;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      decoration: BoxDecoration(
        color: ColorManager.baseWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: ColorManager.grey300,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 16.h),
          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Words Preview',
                        style: TextStyle(
                          fontSize: 18.sp.clamp(16, 20),
                          fontWeight: FontWeight.w700,
                          color: ColorManager.grey950,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        unitTitle,
                        style: TextStyle(
                          fontSize: 14.sp.clamp(13, 16),
                          fontWeight: FontWeight.w500,
                          color: ColorManager.grey500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: ColorManager.purpleLight,
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  child: Text(
                    '${words.length} words',
                    style: TextStyle(
                      fontSize: 13.sp.clamp(12, 15),
                      fontWeight: FontWeight.w600,
                      color: ColorManager.purpleHard,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          const Divider(height: 1, color: ColorManager.grey100),
          // Words list
          Flexible(
            child: words.isEmpty
                ? Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.text_fields_rounded,
                            size: 48.r,
                            color: ColorManager.grey300,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            'No words available',
                            style: TextStyle(
                              fontSize: 14.sp.clamp(13, 16),
                              fontWeight: FontWeight.w500,
                              color: ColorManager.grey500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    shrinkWrap: true,
                    itemCount: words.length,
                    separatorBuilder: (context, index) => SizedBox(height: 8.h),
                    itemBuilder: (context, index) {
                      final word = words[index];
                      return _WordPreviewItem(
                        index: index + 1,
                        word: word,
                      );
                    },
                  ),
          ),
          // Bottom padding
          SizedBox(height: MediaQuery.of(context).padding.bottom + 16.h),
        ],
      ),
    );
  }
}

/// Individual word item in the preview list
class _WordPreviewItem extends StatelessWidget {
  const _WordPreviewItem({
    required this.index,
    required this.word,
  });

  final int index;
  final StudyWord word;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorManager.grey50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorManager.grey100),
      ),
      child: Row(
        children: [
          // Index number
          Container(
            width: 28.r,
            height: 28.r,
            decoration: BoxDecoration(
              color: ColorManager.purpleLight,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: Text(
                '$index',
                style: TextStyle(
                  fontSize: 12.sp.clamp(11, 14),
                  fontWeight: FontWeight.w600,
                  color: ColorManager.purpleHard,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          // Word content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        word.english,
                        style: TextStyle(
                          fontSize: 15.sp.clamp(14, 17),
                          fontWeight: FontWeight.w600,
                          color: ColorManager.grey950,
                        ),
                      ),
                    ),
                    if (word.partOfSpeech != null)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: ColorManager.grey200,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          word.partOfSpeech!,
                          style: TextStyle(
                            fontSize: 10.sp.clamp(9, 12),
                            fontWeight: FontWeight.w500,
                            color: ColorManager.grey600,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  word.vietnamese,
                  style: TextStyle(
                    fontSize: 13.sp.clamp(12, 15),
                    fontWeight: FontWeight.w400,
                    color: ColorManager.grey500,
                  ),
                ),
                if (word.pronunciation != null) ...[
                  SizedBox(height: 2.h),
                  Text(
                    word.pronunciation!,
                    style: TextStyle(
                      fontSize: 12.sp.clamp(11, 14),
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic,
                      color: ColorManager.grey400,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
