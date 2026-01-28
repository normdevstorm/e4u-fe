import 'package:flutter/material.dart';
import 'package:e4u_application/presentation/common/base_wrapper.dart';
import 'package:e4u_application/presentation/study/domain/models/study_models.dart';
import 'package:e4u_application/presentation/study/ui/controllers/study_session_controller.dart';
import 'package:e4u_application/presentation/study/ui/screen/study_lesson_selection_mobile_screen.dart';
import 'package:e4u_application/presentation/study/ui/screen/study_lesson_selection_desktop_screen.dart';
import 'package:e4u_application/presentation/study/ui/screen/study_session_mobile_screen.dart';
import 'package:e4u_application/presentation/study/ui/screen/study_session_desktop_screen.dart';

/// Main lesson selection screen using BaseWrapper for responsive design.
/// Shows lessons for a specific curriculum when navigated from LearningCourseScreen.
class StudyLessonSelectionScreen extends StatefulWidget {
  const StudyLessonSelectionScreen({
    super.key,
    required this.curriculumId,
  });

  final String curriculumId;

  @override
  State<StudyLessonSelectionScreen> createState() =>
      _StudyLessonSelectionScreenState();
}

class _StudyLessonSelectionScreenState
    extends State<StudyLessonSelectionScreen> {
  late final StudySessionController _controller;
  bool _isInStudySession = false;

  @override
  void initState() {
    super.initState();
    _controller = StudySessionController();
    _loadLessons();
  }

  Future<void> _loadLessons() async {
    // Load lessons for the specific curriculum
    await _controller.loadLessons(widget.curriculumId);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleBack() {
    if (_isInStudySession) {
      // Show confirmation dialog before leaving study session
      _showExitConfirmationDialog();
    } else {
      Navigator.of(context).maybePop();
    }
  }

  void _showExitConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Leave Session?'),
        content: const Text(
          'Your progress in this session will be lost. Are you sure you want to leave?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Continue'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _controller.endSession();
              setState(() {
                _isInStudySession = false;
              });
            },
            child: const Text('Leave'),
          ),
        ],
      ),
    );
  }

  void _handleLessonSelected(StudyLesson lesson, int partIndex) async {
    // Select the lesson first
    _controller.selectLesson(lesson);

    // Configure words to learn based on part
    final wordsCount = lesson.parts[partIndex].words.length.clamp(1, 5);
    _controller.setCommittedTime(wordsCount * 2); // 2 min per word estimate

    // Start the session
    await _controller.startSession();

    setState(() {
      _isInStudySession = true;
    });
  }

  void _handleSessionClose() {
    _controller.endSession();
    setState(() {
      _isInStudySession = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isInStudySession) {
      return BaseWrapper(
        mobile: StudySessionMobileScreen(
          controller: _controller,
          onClose: _handleSessionClose,
        ),
        desktop: StudySessionDesktopScreen(
          controller: _controller,
          onClose: _handleSessionClose,
        ),
      );
    }

    return BaseWrapper(
      mobile: StudyLessonSelectionMobileScreen(
        controller: _controller,
        onLessonSelected: _handleLessonSelected,
        onBack: _handleBack,
      ),
      desktop: StudyLessonSelectionDesktopScreen(
        controller: _controller,
        onLessonSelected: _handleLessonSelected,
        onBack: _handleBack,
      ),
    );
  }
}
