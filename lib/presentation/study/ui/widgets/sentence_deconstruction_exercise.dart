import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e4u_application/app/app.dart';
import 'package:e4u_application/presentation/study/domain/models/study_models.dart';

/// Phase 2: Sentence Deconstruction Exercise Widget
/// User reconstructs a sentence from shuffled words/phrases.
class SentenceDeconstructionExerciseWidget extends StatefulWidget {
  const SentenceDeconstructionExerciseWidget({
    super.key,
    required this.exercise,
    required this.onAnswer,
  });

  final SentenceDeconstructionExercise exercise;
  final void Function(bool isCorrect) onAnswer;

  @override
  State<SentenceDeconstructionExerciseWidget> createState() =>
      _SentenceDeconstructionExerciseWidgetState();
}

class _SentenceDeconstructionExerciseWidgetState
    extends State<SentenceDeconstructionExerciseWidget> {
  List<String> _availableWords = [];
  final List<String> _selectedWords = [];
  bool _hasAnswered = false;
  bool _isCorrect = false;

  @override
  void initState() {
    super.initState();
    _availableWords = List.from(widget.exercise.shuffledParts);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          _buildHeader(),
          SizedBox(height: 24.h),

          // Target word hint
          _buildTargetWordHint(),
          SizedBox(height: 24.h),

          // Answer area
          _buildAnswerArea(),
          SizedBox(height: 24.h),

          // Available words
          _buildAvailableWords(),
          SizedBox(height: 24.h),

          // Action buttons
          _buildActionButtons(),
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
              Icons.reorder_rounded,
              size: 24.r,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'Arrange the words to form a correct sentence',
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

  Widget _buildTargetWordHint() {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: ColorManager.purpleLight,
          borderRadius: BorderRadius.circular(100.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.lightbulb_outline_rounded,
              size: 18.r,
              color: ColorManager.purpleHard,
            ),
            SizedBox(width: 8.w),
            Text(
              'Use: "${widget.exercise.targetWord.english}"',
              style: TextStyle(
                fontSize: 14.sp.clamp(12, 16),
                fontWeight: FontWeight.w600,
                color: ColorManager.purpleHard,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerArea() {
    Color borderColor = ColorManager.grey200;
    Color backgroundColor = ColorManager.baseWhite;

    if (_hasAnswered) {
      if (_isCorrect) {
        borderColor = const Color(0xFF4CAF50);
        backgroundColor = const Color(0xFFE8F5E9);
      } else {
        borderColor = const Color(0xFFF44336);
        backgroundColor = const Color(0xFFFFEBEE);
      }
    }

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: 120.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: borderColor, width: 2),
      ),
      child: _selectedWords.isEmpty
          ? Center(
              child: Text(
                'Tap words below to build your sentence',
                style: TextStyle(
                  fontSize: 14.sp.clamp(12, 16),
                  fontWeight: FontWeight.w400,
                  color: ColorManager.grey400,
                ),
              ),
            )
          : Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: _selectedWords.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: _hasAnswered ? null : () => _removeWord(entry.key),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: ColorManager.purpleHard,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      entry.value,
                      style: TextStyle(
                        fontSize: 16.sp.clamp(14, 18),
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
    );
  }

  Widget _buildAvailableWords() {
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      alignment: WrapAlignment.center,
      children: _availableWords.map((word) {
        return GestureDetector(
          onTap: _hasAnswered ? null : () => _selectWord(word),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: ColorManager.baseWhite,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: ColorManager.grey300, width: 1.5),
            ),
            child: Text(
              word,
              style: TextStyle(
                fontSize: 16.sp.clamp(14, 18),
                fontWeight: FontWeight.w500,
                color: ColorManager.grey950,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        if (!_hasAnswered && _selectedWords.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _clearAll,
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  side: const BorderSide(color: ColorManager.grey300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Clear All',
                  style: TextStyle(
                    fontSize: 14.sp.clamp(12, 16),
                    fontWeight: FontWeight.w600,
                    color: ColorManager.grey700,
                  ),
                ),
              ),
            ),
          ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _selectedWords.isEmpty
                ? null
                : (_hasAnswered ? _continue : _checkAnswer),
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
              _hasAnswered ? 'Continue' : 'Check Answer',
              style: TextStyle(
                fontSize: 16.sp.clamp(14, 18),
                fontWeight: FontWeight.w600,
                color: _selectedWords.isEmpty
                    ? ColorManager.grey500
                    : Colors.white,
              ),
            ),
          ),
        ),
        if (_hasAnswered && !_isCorrect) ...[
          SizedBox(height: 16.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: ColorManager.grey50,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Correct Answer:',
                  style: TextStyle(
                    fontSize: 12.sp.clamp(11, 14),
                    fontWeight: FontWeight.w500,
                    color: ColorManager.grey500,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  widget.exercise.correctSentence,
                  style: TextStyle(
                    fontSize: 16.sp.clamp(14, 18),
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2E7D32),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  void _selectWord(String word) {
    setState(() {
      _availableWords.remove(word);
      _selectedWords.add(word);
    });
  }

  void _removeWord(int index) {
    setState(() {
      final word = _selectedWords.removeAt(index);
      _availableWords.add(word);
    });
  }

  void _clearAll() {
    setState(() {
      _availableWords.addAll(_selectedWords);
      _selectedWords.clear();
    });
  }

  void _checkAnswer() {
    final userSentence = _selectedWords.join(' ');
    final correctSentence = widget.exercise.correctSentence;

    // Normalize both sentences for comparison
    final normalizedUser = userSentence.toLowerCase().trim();
    final normalizedCorrect = correctSentence.toLowerCase().trim();

    setState(() {
      _hasAnswered = true;
      _isCorrect = normalizedUser == normalizedCorrect;
    });
  }

  void _continue() {
    widget.onAnswer(_isCorrect);
  }
}
