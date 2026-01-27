import 'package:flutter/material.dart';
import 'package:e4u_application/presentation/common/base_wrapper.dart';
import 'package:e4u_application/presentation/learning/ui/controllers/learning_course_controller.dart';
import 'package:e4u_application/presentation/learning/ui/screen/learning_course_mobile_screen.dart';
import 'package:e4u_application/presentation/learning/ui/screen/learning_course_desktop_screen.dart';

/// Learning Course screen – implementation of "CURRICULUMN DASHBOARD" from Figma.
///
/// Uses BaseWrapper to render platform-specific UI (mobile/desktop)
/// while sharing logic through LearningCourseController.
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
    // Controller doesn't need dispose for now, but can be added if needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWrapper(
      mobile: LearningCourseMobileScreen(controller: _controller),
      desktop: LearningCourseDesktopScreen(controller: _controller),
    );
  }
}
