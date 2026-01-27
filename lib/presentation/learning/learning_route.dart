import 'package:go_router/go_router.dart';
import 'package:e4u_application/app/route/route_define.dart';
import 'package:e4u_application/presentation/learning/ui/screen/learning_course_screen.dart';

/// Route definition for the Learning tab / Course dashboard.
final learningRoute = GoRoute(
  name: RouteDefine.learning,
  path: '/learning',
  builder: (context, state) => const LearningCourseScreen(),
);
