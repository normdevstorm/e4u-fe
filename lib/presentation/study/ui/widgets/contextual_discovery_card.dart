import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e4u_application/app/app.dart';
import 'package:e4u_application/presentation/study/domain/models/study_models.dart';

/// Phase 1: Contextual Discovery Card
/// Shows English word, Vietnamese translation, media, and context sentence.
class ContextualDiscoveryCard extends StatelessWidget {
  const ContextualDiscoveryCard({
    super.key,
    required this.word,
    required this.cardIndex,
    required this.onContinue,
    this.onPlayAudio,
  });

  final StudyWord word;
  final int cardIndex; // 0, 1, or 2
  final VoidCallback onContinue;
  final VoidCallback? onPlayAudio;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: ColorManager.baseWhite,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Card indicator
          _buildCardIndicator(),
          SizedBox(height: 24.h),

          // Media section (image/video placeholder)
          _buildMediaSection(),
          SizedBox(height: 24.h),

          // Word section
          _buildWordSection(),
          SizedBox(height: 16.h),

          // Context sentence
          _buildContextSection(),
          SizedBox(height: 32.h),

          // Continue button
          _buildContinueButton(),
        ],
      ),
    );
  }

  Widget _buildCardIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        final isActive = index == cardIndex;
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          width: isActive ? 24.w : 8.w,
          height: 8.h,
          decoration: BoxDecoration(
            color: isActive ? ColorManager.purpleHard : ColorManager.grey200,
            borderRadius: BorderRadius.circular(4.r),
          ),
        );
      }),
    );
  }

  Widget _buildMediaSection() {
    return Container(
      width: double.infinity,
      height: 180.h,
      decoration: BoxDecoration(
        color: ColorManager.grey100,
        borderRadius: BorderRadius.circular(16.r),
        image: word.imageUrl != null
            ? DecorationImage(
                image: NetworkImage(word.imageUrl!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: word.imageUrl == null
          ? Center(
              child: Icon(
                Icons.image_outlined,
                size: 48.r,
                color: ColorManager.grey400,
              ),
            )
          : null,
    );
  }

  Widget _buildWordSection() {
    return Column(
      children: [
        // English word
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              word.english,
              style: TextStyle(
                fontSize: 32.sp.clamp(28, 40),
                fontWeight: FontWeight.w700,
                color: ColorManager.grey950,
              ),
            ),
            if (word.audioUrl != null || onPlayAudio != null) ...[
              SizedBox(width: 12.w),
              GestureDetector(
                onTap: onPlayAudio,
                child: Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: const BoxDecoration(
                    color: ColorManager.purpleLight,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.volume_up_rounded,
                    size: 24.r,
                    color: ColorManager.purpleHard,
                  ),
                ),
              ),
            ],
          ],
        ),

        // Part of speech
        if (word.partOfSpeech != null) ...[
          SizedBox(height: 4.h),
          Text(
            word.partOfSpeech!,
            style: TextStyle(
              fontSize: 14.sp.clamp(12, 16),
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
              color: ColorManager.grey500,
            ),
          ),
        ],

        SizedBox(height: 12.h),

        // Vietnamese translation
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: ColorManager.purpleLight,
            borderRadius: BorderRadius.circular(100.r),
          ),
          child: Text(
            word.vietnamese,
            style: TextStyle(
              fontSize: 18.sp.clamp(16, 22),
              fontWeight: FontWeight.w600,
              color: ColorManager.purpleHard,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContextSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.grey50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorManager.grey200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.format_quote_rounded,
                size: 20.r,
                color: ColorManager.purpleHard,
              ),
              SizedBox(width: 8.w),
              Text(
                'Example',
                style: TextStyle(
                  fontSize: 12.sp.clamp(11, 14),
                  fontWeight: FontWeight.w600,
                  color: ColorManager.grey500,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            word.contextSentence,
            style: TextStyle(
              fontSize: 16.sp.clamp(14, 18),
              fontWeight: FontWeight.w500,
              color: ColorManager.grey950,
              height: 1.5,
            ),
          ),
          if (word.contextSentenceTranslation != null) ...[
            SizedBox(height: 8.h),
            Text(
              word.contextSentenceTranslation!,
              style: TextStyle(
                fontSize: 14.sp.clamp(12, 16),
                fontWeight: FontWeight.w400,
                color: ColorManager.grey500,
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
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
          cardIndex < 2 ? 'Next' : 'Got it!',
          style: TextStyle(
            fontSize: 16.sp.clamp(14, 18),
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
