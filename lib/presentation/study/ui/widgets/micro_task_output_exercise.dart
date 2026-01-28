import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e4u_application/app/app.dart';
import 'package:e4u_application/presentation/study/domain/models/study_models.dart';

/// Phase 3: Micro Task Output Exercise Widget
/// Handles both medium and hard difficulty levels.
class MicroTaskOutputExerciseWidget extends StatefulWidget {
  const MicroTaskOutputExerciseWidget({
    super.key,
    required this.exercise,
    required this.onAnswer,
  });

  final StudyExercise exercise;
  final void Function(bool isCorrect) onAnswer;

  @override
  State<MicroTaskOutputExerciseWidget> createState() =>
      _MicroTaskOutputExerciseWidgetState();
}

class _MicroTaskOutputExerciseWidgetState
    extends State<MicroTaskOutputExerciseWidget> {
  final TextEditingController _textController = TextEditingController();
  bool _hasAnswered = false;
  bool _isCorrect = false;
  String _feedback = '';

  bool get isMediumLevel =>
      widget.exercise.type == ExerciseType.microTaskMedium;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            _buildHeader(),
            SizedBox(height: 24.h),

            // Context/Prompt section
            _buildContextSection(),
            SizedBox(height: 20.h),

            // Hints (for hard level)
            if (!isMediumLevel) ...[
              _buildHintsSection(),
              SizedBox(height: 20.h),
            ],

            // Input area
            _buildInputArea(),
            SizedBox(height: 16.h),

            // Feedback area (after answering)
            if (_hasAnswered) ...[
              _buildFeedbackArea(),
              SizedBox(height: 16.h),
            ],

            // Action button
            _buildActionButton(),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color:
            isMediumLevel ? const Color(0xFFFFF3E0) : const Color(0xFFFFEBEE),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: isMediumLevel
                  ? const Color(0xFFFF9800)
                  : const Color(0xFFF44336),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isMediumLevel
                  ? Icons.edit_note_rounded
                  : Icons.psychology_rounded,
              size: 24.r,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isMediumLevel ? 'Medium Challenge' : 'Hard Challenge',
                  style: TextStyle(
                    fontSize: 12.sp.clamp(10, 14),
                    fontWeight: FontWeight.w600,
                    color: isMediumLevel
                        ? const Color(0xFFE65100)
                        : const Color(0xFFC62828),
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  isMediumLevel
                      ? 'Complete the sentence'
                      : 'Create your own sentence',
                  style: TextStyle(
                    fontSize: 16.sp.clamp(14, 18),
                    fontWeight: FontWeight.w600,
                    color: ColorManager.grey950,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContextSection() {
    String contextText = '';
    if (isMediumLevel) {
      final exercise = widget.exercise as MicroTaskMediumExercise;
      contextText = exercise.prompt;
    } else {
      final exercise = widget.exercise as MicroTaskHardExercise;
      contextText = exercise.context;
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.baseWhite,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorManager.grey200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb_outline_rounded,
                size: 18.r,
                color: ColorManager.purpleHard,
              ),
              SizedBox(width: 8.w),
              Text(
                'Context',
                style: TextStyle(
                  fontSize: 12.sp.clamp(11, 14),
                  fontWeight: FontWeight.w600,
                  color: ColorManager.grey500,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            contextText,
            style: TextStyle(
              fontSize: 16.sp.clamp(14, 18),
              fontWeight: FontWeight.w500,
              color: ColorManager.grey950,
              height: 1.5,
            ),
          ),
          if (isMediumLevel) ...[
            SizedBox(height: 16.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: ColorManager.grey50,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                (widget.exercise as MicroTaskMediumExercise).partialSentence,
                style: TextStyle(
                  fontSize: 16.sp.clamp(14, 18),
                  fontWeight: FontWeight.w600,
                  color: ColorManager.grey700,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHintsSection() {
    final exercise = widget.exercise as MicroTaskHardExercise;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hints',
          style: TextStyle(
            fontSize: 14.sp.clamp(12, 16),
            fontWeight: FontWeight.w600,
            color: ColorManager.grey700,
          ),
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: exercise.hints.map((hint) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: ColorManager.purpleLight,
                borderRadius: BorderRadius.circular(100.r),
                border: Border.all(color: ColorManager.purpleHard),
              ),
              child: Text(
                hint,
                style: TextStyle(
                  fontSize: 14.sp.clamp(12, 16),
                  fontWeight: FontWeight.w600,
                  color: ColorManager.purpleHard,
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 12.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: ColorManager.grey50,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Simpler version:',
                style: TextStyle(
                  fontSize: 12.sp.clamp(10, 14),
                  fontWeight: FontWeight.w500,
                  color: ColorManager.grey500,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                exercise.simplerVersion,
                style: TextStyle(
                  fontSize: 14.sp.clamp(12, 16),
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  color: ColorManager.grey700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInputArea() {
    Color borderColor = ColorManager.grey200;
    if (_hasAnswered) {
      borderColor =
          _isCorrect ? const Color(0xFF4CAF50) : const Color(0xFFF44336);
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: borderColor, width: 2),
      ),
      child: TextField(
        controller: _textController,
        enabled: !_hasAnswered,
        maxLines: 3,
        style: TextStyle(
          fontSize: 16.sp.clamp(14, 18),
          fontWeight: FontWeight.w500,
          color: ColorManager.grey950,
        ),
        decoration: InputDecoration(
          hintText: 'Type your sentence here...',
          hintStyle: TextStyle(
            fontSize: 16.sp.clamp(14, 18),
            fontWeight: FontWeight.w400,
            color: ColorManager.grey400,
          ),
          contentPadding: EdgeInsets.all(16.w),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildFeedbackArea() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: _isCorrect ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _isCorrect
                    ? Icons.check_circle_rounded
                    : Icons.info_outline_rounded,
                size: 20.r,
                color: _isCorrect
                    ? const Color(0xFF4CAF50)
                    : const Color(0xFFF44336),
              ),
              SizedBox(width: 8.w),
              Text(
                _isCorrect ? 'Great job!' : 'Feedback',
                style: TextStyle(
                  fontSize: 14.sp.clamp(12, 16),
                  fontWeight: FontWeight.w600,
                  color: _isCorrect
                      ? const Color(0xFF2E7D32)
                      : const Color(0xFFC62828),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            _feedback,
            style: TextStyle(
              fontSize: 14.sp.clamp(12, 16),
              fontWeight: FontWeight.w500,
              color: ColorManager.grey800,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    // Use ValueListenableBuilder to only rebuild the button when text changes
    // This is more efficient than setState which rebuilds the entire widget
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: _textController,
      builder: (context, value, child) {
        final bool canSubmit = value.text.trim().isNotEmpty;

        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: canSubmit || _hasAnswered
                ? (_hasAnswered ? _continue : _checkAnswer)
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.purpleHard,
              disabledBackgroundColor: ColorManager.grey200,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
            ),
            child: Text(
              _hasAnswered ? 'Continue' : 'Submit',
              style: TextStyle(
                fontSize: 16.sp.clamp(14, 18),
                fontWeight: FontWeight.w600,
                color: canSubmit || _hasAnswered
                    ? Colors.white
                    : ColorManager.grey500,
              ),
            ),
          ),
        );
      },
    );
  }

  void _checkAnswer() {
    final userInput = _textController.text.trim().toLowerCase();
    final targetWord = widget.exercise.targetWord.english.toLowerCase();

    // Check if the user's sentence contains the target word
    final containsTargetWord = userInput.contains(targetWord);

    // Basic validation: sentence should be reasonable length
    final hasReasonableLength = userInput.split(' ').length >= 3;

    setState(() {
      _hasAnswered = true;
      _isCorrect = containsTargetWord && hasReasonableLength;

      if (_isCorrect) {
        _feedback =
            'Your sentence correctly uses "${widget.exercise.targetWord.english}". Well done!';
      } else if (!containsTargetWord) {
        _feedback =
            'Make sure to include the target word "${widget.exercise.targetWord.english}" in your sentence.';
      } else {
        _feedback = 'Try to form a complete sentence with at least 3 words.';
      }

      // TODO: Integrate with AI for more sophisticated evaluation
    });
  }

  void _continue() {
    widget.onAnswer(_isCorrect);
  }
}
