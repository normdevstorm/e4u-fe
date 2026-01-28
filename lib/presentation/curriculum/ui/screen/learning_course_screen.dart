import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:e4u_application/app/route/route_define.dart';
import 'package:e4u_application/presentation/common/base_wrapper.dart';
import 'package:e4u_application/presentation/curriculum/ui/controllers/learning_course_controller.dart';
import 'package:e4u_application/presentation/curriculum/ui/screen/learning_course_mobile_screen.dart';
import 'package:e4u_application/presentation/curriculum/ui/screen/learning_course_desktop_screen.dart';

/// Learning Course screen – displays all curriculums.
///
/// Uses BaseWrapper to render platform-specific UI (mobile/desktop)
/// while sharing logic through LearningCourseController.
///
/// Flow:
/// - Shows all curriculums as cards
/// - Current curriculum is highlighted and placed on top
/// - Clicking a card navigates to StudyLessonSelectionScreen
class LearningCourseScreen extends StatefulWidget {
  const LearningCourseScreen({super.key});

  @override
  State<LearningCourseScreen> createState() => _LearningCourseScreenState();
}

class _LearningCourseScreenState extends State<LearningCourseScreen> {
  late final LearningCourseController _controller;

  @override
  void initState() {
    super.initState();
    _controller = LearningCourseController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Handle curriculum card tap - navigate to lesson selection screen
  void _handleCurriculumTap(String curriculumId) {
    // Navigate to study/lesson selection screen with the curriculum ID
    context.goNamed(
      RouteDefine.study,
      pathParameters: {'curriculumId': curriculumId},
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseWrapper(
      mobile: LearningCourseMobileScreen(
        controller: _controller,
        onCurriculumTap: _handleCurriculumTap,
      ),
      desktop: LearningCourseDesktopScreen(
        controller: _controller,
        onCurriculumTap: _handleCurriculumTap,
      ),
    );
  }
}
