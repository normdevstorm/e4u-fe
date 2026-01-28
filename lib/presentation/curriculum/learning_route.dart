import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:e4u_application/app/route/route_define.dart';
import 'package:e4u_application/presentation/curriculum/ui/screen/learning_course_screen.dart';
import 'package:e4u_application/presentation/study/ui/screen/study_unit_selection_screen.dart';
part 'learning_route.g.dart';

@TypedGoRoute<LearningScreenRoute>(
    path: '/learning',
    name: RouteDefine.learning,
    routes: [
      TypedGoRoute<StudyRoute>(
          path: "study/:curriculumId", name: RouteDefine.study)
    ])
@immutable
class LearningScreenRoute extends GoRouteData with $LearningScreenRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LearningCourseScreen();
  }
}

@immutable
class StudyRoute extends GoRouteData with $StudyRoute {
  final String curriculumId;

  const StudyRoute({
    required this.curriculumId,
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return StudyUnitSelectionScreen(curriculumId: curriculumId);
  }
}
