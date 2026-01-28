import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e4u_application/app/app.dart';
import 'package:e4u_application/presentation/study/domain/models/study_models.dart';

/// Phase 2: Cloze/Listen Match Exercise Widget
/// A sentence with a blank that user needs to fill.
class ClozeExerciseWidget extends StatefulWidget {
  const ClozeExerciseWidget({
    super.key,
    required this.exercise,
    required this.onAnswer,
    this.onPlayAudio,
  });

  final ClozeExercise exercise;
  final void Function(bool isCorrect) onAnswer;
  final VoidCallback? onPlayAudio;

  @override
  State<ClozeExerciseWidget> createState() => _ClozeExerciseWidgetState();
}

class _ClozeExerciseWidgetState extends State<ClozeExerciseWidget> {
  String? _selectedOption;
  bool _hasAnswered = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Exercise header
          _buildHeader(),
          SizedBox(height: 24.h),

          // Audio button (if available)
          if (widget.exercise.hasAudio) ...[
            _buildAudioButton(),
            SizedBox(height: 24.h),
          ],

          // Sentence with blank
          _buildSentence(),
          SizedBox(height: 32.h),

          // Word options
          _buildOptions(),
          SizedBox(height: 24.h),

          // Action button
          if (_selectedOption != null) _buildActionButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.grey50,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: const BoxDecoration(
              color: ColorManager.purpleHard,
              shape: BoxShape.circle,
            ),
            child: Icon(
              widget.exercise.hasAudio
                  ? Icons.hearing_rounded
                  : Icons.edit_rounded,
              size: 24.r,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              widget.exercise.hasAudio
                  ? 'Listen and fill in the blank'
                  : 'Fill in the blank with the correct word',
              style: TextStyle(
                fontSize: 16.sp.clamp(14, 18),
                fontWeight: FontWeight.w600,
                color: ColorManager.grey950,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAudioButton() {
    return Center(
      child: GestureDetector(
        onTap: widget.onPlayAudio,
        child: Container(
          padding: EdgeInsets.all(24.r),
          decoration: BoxDecoration(
            color: ColorManager.purpleLight,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: ColorManager.purpleHard.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            Icons.volume_up_rounded,
            size: 48.r,
            color: ColorManager.purpleHard,
          ),
        ),
      ),
    );
  }

  Widget _buildSentence() {
    final parts = widget.exercise.sentenceWithBlank.split('_____');

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: ColorManager.baseWhite,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorManager.grey200),
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            fontSize: 20.sp.clamp(18, 24),
            fontWeight: FontWeight.w500,
            color: ColorManager.grey950,
            height: 1.6,
          ),
          children: [
            if (parts.isNotEmpty) TextSpan(text: parts[0]),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: _selectedOption != null
                      ? (_hasAnswered
                          ? (_selectedOption == widget.exercise.correctAnswer
                              ? const Color(0xFFE8F5E9)
                              : const Color(0xFFFFEBEE))
                          : ColorManager.purpleLight)
                      : ColorManager.grey100,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: _selectedOption != null
                        ? (_hasAnswered
                            ? (_selectedOption == widget.exercise.correctAnswer
                                ? const Color(0xFF4CAF50)
                                : const Color(0xFFF44336))
                            : ColorManager.purpleHard)
                        : ColorManager.grey300,
                    width: 2,
                  ),
                ),
                child: Text(
                  _selectedOption ?? '________',
                  style: TextStyle(
                    fontSize: 20.sp.clamp(18, 24),
                    fontWeight: FontWeight.w600,
                    color: _selectedOption != null
                        ? (_hasAnswered
                            ? (_selectedOption == widget.exercise.correctAnswer
                                ? const Color(0xFF2E7D32)
                                : const Color(0xFFC62828))
                            : ColorManager.purpleHard)
                        : ColorManager.grey400,
                  ),
                ),
              ),
            ),
            if (parts.length > 1) TextSpan(text: parts[1]),
          ],
        ),
      ),
    );
  }

  Widget _buildOptions() {
    return Wrap(
      spacing: 12.w,
      runSpacing: 12.h,
      alignment: WrapAlignment.center,
      children: widget.exercise.options.map((option) {
        final isSelected = _selectedOption == option;
        final isCorrect = option == widget.exercise.correctAnswer;

        Color backgroundColor = ColorManager.baseWhite;
        Color borderColor = ColorManager.grey200;
        Color textColor = ColorManager.grey950;

        if (_hasAnswered) {
          if (isCorrect) {
            backgroundColor = const Color(0xFFE8F5E9);
            borderColor = const Color(0xFF4CAF50);
            textColor = const Color(0xFF2E7D32);
          } else if (isSelected && !isCorrect) {
            backgroundColor = const Color(0xFFFFEBEE);
            borderColor = const Color(0xFFF44336);
            textColor = const Color(0xFFC62828);
          }
        } else if (isSelected) {
          backgroundColor = ColorManager.purpleLight;
          borderColor = ColorManager.purpleHard;
          textColor = ColorManager.purpleHard;
        }

        return GestureDetector(
          onTap: _hasAnswered ? null : () => _selectOption(option),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(100.r),
              border: Border.all(color: borderColor, width: 2),
            ),
            child: Text(
              option,
              style: TextStyle(
                fontSize: 16.sp.clamp(14, 18),
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActionButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _hasAnswered ? _continue : _checkAnswer,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.purpleHard,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
        ),
        child: Text(
          _hasAnswered ? 'Continue' : 'Check Answer',
          style: TextStyle(
            fontSize: 16.sp.clamp(14, 18),
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _selectOption(String option) {
    setState(() {
      _selectedOption = option;
    });
  }

  void _checkAnswer() {
    if (_selectedOption == null) return;

    setState(() {
      _hasAnswered = true;
    });
  }

  void _continue() {
    final isCorrect = _selectedOption == widget.exercise.correctAnswer;
    widget.onAnswer(isCorrect);
  }
}
