import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e4u_application/app/app.dart';
import 'package:e4u_application/presentation/study/domain/models/study_models.dart';

/// Phase 2: Multiple Choice Exercise Widget
class MultipleChoiceExerciseWidget extends StatefulWidget {
  const MultipleChoiceExerciseWidget({
    super.key,
    required this.exercise,
    required this.onAnswer,
  });

  final MultipleChoiceExercise exercise;
  final void Function(bool isCorrect) onAnswer;

  @override
  State<MultipleChoiceExerciseWidget> createState() =>
      _MultipleChoiceExerciseWidgetState();
}

class _MultipleChoiceExerciseWidgetState
    extends State<MultipleChoiceExerciseWidget> {
  int? _selectedIndex;
  bool _hasAnswered = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question header
          _buildQuestionHeader(),
          SizedBox(height: 24.h),

          // Word being tested
          _buildTargetWord(),
          SizedBox(height: 32.h),

          // Options
          ..._buildOptions(),
          SizedBox(height: 24.h),

          // Submit/Continue button
          if (_selectedIndex != null) _buildActionButton(),
        ],
      ),
    );
  }

  Widget _buildQuestionHeader() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.purpleLight,
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
              Icons.quiz_rounded,
              size: 24.r,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              widget.exercise.question,
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

  Widget _buildTargetWord() {
    return Center(
      child: Column(
        children: [
          Text(
            widget.exercise.targetWord.english,
            style: TextStyle(
              fontSize: 36.sp.clamp(28, 44),
              fontWeight: FontWeight.w700,
              color: ColorManager.grey950,
            ),
          ),
          if (widget.exercise.targetWord.pronunciation != null) ...[
            SizedBox(height: 4.h),
            Text(
              widget.exercise.targetWord.pronunciation!,
              style: TextStyle(
                fontSize: 14.sp.clamp(12, 16),
                fontWeight: FontWeight.w400,
                color: ColorManager.grey500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  List<Widget> _buildOptions() {
    return widget.exercise.options.asMap().entries.map((entry) {
      final index = entry.key;
      final option = entry.value;
      final isSelected = _selectedIndex == index;
      final isCorrect = index == widget.exercise.correctAnswerIndex;

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

      return Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: InkWell(
          onTap: _hasAnswered ? null : () => _selectOption(index),
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: borderColor, width: 2),
            ),
            child: Row(
              children: [
                Container(
                  width: 32.r,
                  height: 32.r,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? borderColor.withOpacity(0.2)
                        : ColorManager.grey100,
                    shape: BoxShape.circle,
                    border: Border.all(color: borderColor),
                  ),
                  child: Center(
                    child: _hasAnswered
                        ? Icon(
                            isCorrect
                                ? Icons.check_rounded
                                : (isSelected ? Icons.close_rounded : null),
                            size: 18.r,
                            color: textColor,
                          )
                        : Text(
                            String.fromCharCode(65 + index), // A, B, C, D
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    option,
                    style: TextStyle(
                      fontSize: 16.sp.clamp(14, 18),
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildActionButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _hasAnswered ? _continue : _checkAnswer,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              _hasAnswered ? ColorManager.purpleHard : ColorManager.purpleHard,
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

  void _selectOption(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _checkAnswer() {
    if (_selectedIndex == null) return;

    setState(() {
      _hasAnswered = true;
    });
  }

  void _continue() {
    final isCorrect = _selectedIndex == widget.exercise.correctAnswerIndex;
    widget.onAnswer(isCorrect);
  }
}
