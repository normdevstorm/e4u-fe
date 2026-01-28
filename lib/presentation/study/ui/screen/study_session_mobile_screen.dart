import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e4u_application/app/app.dart';
import 'package:e4u_application/presentation/study/domain/models/study_models.dart';
import 'package:e4u_application/presentation/study/ui/controllers/study_session_controller.dart';
import 'package:e4u_application/presentation/study/ui/widgets/study_widgets.dart';

/// Mobile screen for the study session.
class StudySessionMobileScreen extends StatelessWidget {
  const StudySessionMobileScreen({
    super.key,
    required this.controller,
    required this.onClose,
  });

  final StudySessionController controller;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final session = controller.currentSession;

        if (session == null) {
          return _buildNoSession();
        }

        if (session.currentPhase == StudyPhase.completed) {
          return _buildSessionComplete(session);
        }

        return Scaffold(
          backgroundColor: ColorManager.grey50,
          body: Column(
            children: [
              // Progress header
              StudyProgressHeader(
                session: session,
                onClose: onClose,
              ),

              // Exercise content
              Expanded(
                child: _buildExerciseContent(session),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNoSession() {
    return Scaffold(
      backgroundColor: ColorManager.grey50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school_rounded,
              size: 64.r,
              color: ColorManager.grey400,
            ),
            SizedBox(height: 16.h),
            Text(
              'No active session',
              style: TextStyle(
                fontSize: 18.sp.clamp(16, 20),
                fontWeight: FontWeight.w600,
                color: ColorManager.grey700,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Select a lesson to start learning',
              style: TextStyle(
                fontSize: 14.sp.clamp(12, 16),
                fontWeight: FontWeight.w400,
                color: ColorManager.grey500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionComplete(StudySession session) {
    return Scaffold(
      backgroundColor: ColorManager.grey50,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 32.h),
          child: StudySessionCompleteCard(
            session: session,
            onContinue: onClose,
            onReview: () {
              // TODO: Implement review functionality
            },
          ),
        ),
      ),
    );
  }

  Widget _buildExerciseContent(StudySession session) {
    final currentExercise = controller.currentExercise;
    if (currentExercise == null) {
      return const SizedBox.shrink();
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.1, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            )),
            child: child,
          ),
        );
      },
      child: _buildExerciseWidget(currentExercise, session),
    );
  }

  Widget _buildExerciseWidget(StudyExercise exercise, StudySession session) {
    switch (exercise.type) {
      case ExerciseType.contextualDiscovery:
        return _buildContextualDiscovery(
          exercise as ContextualDiscoveryExercise,
          session,
        );
      case ExerciseType.multipleChoice:
        return _buildMultipleChoice(
          exercise as MultipleChoiceExercise,
          session,
        );
      case ExerciseType.clozeListenMatch:
        return _buildCloze(exercise as ClozeExercise, session);
      case ExerciseType.sentenceDeconstruction:
        return _buildSentenceDeconstruction(
          exercise as SentenceDeconstructionExercise,
          session,
        );
      case ExerciseType.microTaskMedium:
        return _buildMicroTaskMedium(
          exercise as MicroTaskMediumExercise,
          session,
        );
      case ExerciseType.microTaskHard:
        return _buildMicroTaskHard(
          exercise as MicroTaskHardExercise,
          session,
        );
    }
  }

  Widget _buildContextualDiscovery(
    ContextualDiscoveryExercise exercise,
    StudySession session,
  ) {
    return ContextualDiscoveryCard(
      key:
          ValueKey('discovery_${exercise.targetWord.id}_${exercise.cardIndex}'),
      word: exercise.targetWord,
      cardIndex: exercise.cardIndex,
      onContinue: () {
        controller.submitExerciseAnswer(null);
      },
    );
  }

  Widget _buildMultipleChoice(
    MultipleChoiceExercise exercise,
    StudySession session,
  ) {
    return MultipleChoiceExerciseWidget(
      key: ValueKey('mc_${exercise.targetWord.id}'),
      exercise: exercise,
      onAnswer: (isCorrect) {
        controller.recordAnswer(isCorrect);
        controller.submitExerciseAnswer(isCorrect);
      },
    );
  }

  Widget _buildCloze(ClozeExercise exercise, StudySession session) {
    return ClozeExerciseWidget(
      key: ValueKey('cloze_${exercise.targetWord.id}'),
      exercise: exercise,
      onAnswer: (isCorrect) {
        controller.recordAnswer(isCorrect);
        controller.submitExerciseAnswer(isCorrect);
      },
    );
  }

  Widget _buildSentenceDeconstruction(
    SentenceDeconstructionExercise exercise,
    StudySession session,
  ) {
    return SentenceDeconstructionExerciseWidget(
      key: ValueKey('sd_${exercise.targetWord.id}'),
      exercise: exercise,
      onAnswer: (isCorrect) {
        controller.recordAnswer(isCorrect);
        controller.submitExerciseAnswer(isCorrect);
      },
    );
  }

  Widget _buildMicroTaskMedium(
    MicroTaskMediumExercise exercise,
    StudySession session,
  ) {
    return MicroTaskOutputExerciseWidget(
      key: ValueKey('mtm_${exercise.targetWord.id}'),
      exercise: exercise,
      onAnswer: (isCorrect) {
        controller.recordAnswer(isCorrect);
        controller.submitExerciseAnswer(isCorrect);
      },
    );
  }

  Widget _buildMicroTaskHard(
    MicroTaskHardExercise exercise,
    StudySession session,
  ) {
    return MicroTaskOutputExerciseWidget(
      key: ValueKey('mth_${exercise.targetWord.id}'),
      exercise: exercise,
      onAnswer: (isCorrect) {
        controller.recordAnswer(isCorrect);
        controller.submitExerciseAnswer(isCorrect);
      },
    );
  }
}
