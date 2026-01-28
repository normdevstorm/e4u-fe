import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e4u_application/app/app.dart';
import 'package:e4u_application/presentation/study/domain/models/study_models.dart';
import 'package:e4u_application/presentation/study/ui/controllers/study_session_controller.dart';
import 'package:e4u_application/presentation/study/ui/widgets/study_widgets.dart';

/// Desktop screen for the study session.
class StudySessionDesktopScreen extends StatelessWidget {
  const StudySessionDesktopScreen({
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
          body: Row(
            children: [
              // Left sidebar with word list
              _buildSidebar(session),

              // Main content area
              Expanded(
                child: Column(
                  children: [
                    // Progress header (desktop variant)
                    _buildDesktopHeader(session),

                    // Exercise content
                    Expanded(
                      child: Center(
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: 600.w.clamp(400, 800),
                          ),
                          child: _buildExerciseContent(session),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSidebar(StudySession session) {
    return Container(
      width: 280.w.clamp(240, 320),
      decoration: const BoxDecoration(
        color: ColorManager.baseWhite,
        border: Border(
          right: BorderSide(
            color: ColorManager.grey200,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Words in Session',
                  style: TextStyle(
                    fontSize: 18.sp.clamp(16, 20),
                    fontWeight: FontWeight.w600,
                    color: ColorManager.grey950,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '${session.words.length} words',
                  style: TextStyle(
                    fontSize: 14.sp.clamp(12, 16),
                    fontWeight: FontWeight.w500,
                    color: ColorManager.grey500,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: ColorManager.grey200),

          // Word list
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              itemCount: session.words.length,
              itemBuilder: (context, index) {
                final word = session.words[index];
                final currentWord = controller.currentExercise?.targetWord;
                final isCurrentWord = currentWord?.id == word.id;

                return _buildWordListItem(word, isCurrentWord, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWordListItem(StudyWord word, bool isCurrent, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: isCurrent ? ColorManager.purpleLight : Colors.transparent,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Container(
            width: 28.r,
            height: 28.r,
            decoration: BoxDecoration(
              color: isCurrent ? ColorManager.purpleHard : ColorManager.grey200,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  fontSize: 12.sp.clamp(11, 14),
                  fontWeight: FontWeight.w600,
                  color: isCurrent ? Colors.white : ColorManager.grey600,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  word.english,
                  style: TextStyle(
                    fontSize: 14.sp.clamp(13, 16),
                    fontWeight: FontWeight.w600,
                    color: isCurrent
                        ? ColorManager.purpleHard
                        : ColorManager.grey800,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  word.vietnamese,
                  style: TextStyle(
                    fontSize: 12.sp.clamp(11, 14),
                    fontWeight: FontWeight.w400,
                    color: ColorManager.grey500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopHeader(StudySession session) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: const BoxDecoration(
        color: ColorManager.baseWhite,
        border: Border(
          bottom: BorderSide(
            color: ColorManager.grey200,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Close button
          GestureDetector(
            onTap: onClose,
            child: Container(
              width: 44.r,
              height: 44.r,
              decoration: BoxDecoration(
                color: ColorManager.grey100,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.arrow_back_rounded,
                size: 24.r,
                color: ColorManager.grey700,
              ),
            ),
          ),
          SizedBox(width: 20.w),

          // Title and phase
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getPhaseTitle(session.currentPhase),
                  style: TextStyle(
                    fontSize: 20.sp.clamp(18, 22),
                    fontWeight: FontWeight.w600,
                    color: ColorManager.grey950,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  _getPhaseDescription(session.currentPhase),
                  style: TextStyle(
                    fontSize: 14.sp.clamp(12, 16),
                    fontWeight: FontWeight.w400,
                    color: ColorManager.grey500,
                  ),
                ),
              ],
            ),
          ),

          // Progress indicator
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Progress',
                style: TextStyle(
                  fontSize: 12.sp.clamp(11, 14),
                  fontWeight: FontWeight.w500,
                  color: ColorManager.grey500,
                ),
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  SizedBox(
                    width: 120.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4.r),
                      child: LinearProgressIndicator(
                        value: session.progress,
                        backgroundColor: ColorManager.grey200,
                        valueColor: const AlwaysStoppedAnimation(
                          ColorManager.purpleHard,
                        ),
                        minHeight: 8.h,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    '${(session.progress * 100).toInt()}%',
                    style: TextStyle(
                      fontSize: 14.sp.clamp(12, 16),
                      fontWeight: FontWeight.w600,
                      color: ColorManager.purpleHard,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(width: 24.w),

          // Stats chip
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: ColorManager.grey100,
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  size: 20.r,
                  color: const Color(0xFF4CAF50),
                ),
                SizedBox(width: 8.w),
                Text(
                  '${session.correctAnswers} correct',
                  style: TextStyle(
                    fontSize: 14.sp.clamp(12, 16),
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

  String _getPhaseTitle(StudyPhase phase) {
    switch (phase) {
      case StudyPhase.contextualDiscovery:
        return 'Contextual Discovery';
      case StudyPhase.mechanicDrill:
        return 'Practice Session';
      case StudyPhase.microTaskOutput:
        return 'Challenge Mode';
      case StudyPhase.completed:
        return 'Session Complete';
    }
  }

  String _getPhaseDescription(StudyPhase phase) {
    switch (phase) {
      case StudyPhase.contextualDiscovery:
        return 'Learn the words in context';
      case StudyPhase.mechanicDrill:
        return 'Test your knowledge with exercises';
      case StudyPhase.microTaskOutput:
        return 'Apply what you\'ve learned';
      case StudyPhase.completed:
        return 'Great job!';
    }
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
              size: 80.r,
              color: ColorManager.grey400,
            ),
            SizedBox(height: 24.h),
            Text(
              'No active session',
              style: TextStyle(
                fontSize: 24.sp.clamp(20, 28),
                fontWeight: FontWeight.w600,
                color: ColorManager.grey700,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Select a lesson to start learning',
              style: TextStyle(
                fontSize: 16.sp.clamp(14, 18),
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
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 500.w.clamp(400, 600),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 48.h),
            child: StudySessionCompleteCard(
              session: session,
              onContinue: onClose,
              onReview: () {
                // TODO: Implement review functionality
              },
            ),
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
              begin: const Offset(0.05, 0),
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
        );
      case ExerciseType.multipleChoice:
        return _buildMultipleChoice(exercise as MultipleChoiceExercise);
      case ExerciseType.clozeListenMatch:
        return _buildCloze(exercise as ClozeExercise);
      case ExerciseType.sentenceDeconstruction:
        return _buildSentenceDeconstruction(
          exercise as SentenceDeconstructionExercise,
        );
      case ExerciseType.microTaskMedium:
        return _buildMicroTaskMedium(exercise as MicroTaskMediumExercise);
      case ExerciseType.microTaskHard:
        return _buildMicroTaskHard(exercise as MicroTaskHardExercise);
    }
  }

  Widget _buildContextualDiscovery(ContextualDiscoveryExercise exercise) {
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

  Widget _buildMultipleChoice(MultipleChoiceExercise exercise) {
    return MultipleChoiceExerciseWidget(
      key: ValueKey('mc_${exercise.targetWord.id}'),
      exercise: exercise,
      onAnswer: (isCorrect) {
        controller.recordAnswer(isCorrect);
        controller.submitExerciseAnswer(isCorrect);
      },
    );
  }

  Widget _buildCloze(ClozeExercise exercise) {
    return ClozeExerciseWidget(
      key: ValueKey('cloze_${exercise.targetWord.id}'),
      exercise: exercise,
      onAnswer: (isCorrect) {
        controller.recordAnswer(isCorrect);
        controller.submitExerciseAnswer(isCorrect);
      },
    );
  }

  Widget _buildSentenceDeconstruction(SentenceDeconstructionExercise exercise) {
    return SentenceDeconstructionExerciseWidget(
      key: ValueKey('sd_${exercise.targetWord.id}'),
      exercise: exercise,
      onAnswer: (isCorrect) {
        controller.recordAnswer(isCorrect);
        controller.submitExerciseAnswer(isCorrect);
      },
    );
  }

  Widget _buildMicroTaskMedium(MicroTaskMediumExercise exercise) {
    return MicroTaskOutputExerciseWidget(
      key: ValueKey('mtm_${exercise.targetWord.id}'),
      exercise: exercise,
      onAnswer: (isCorrect) {
        controller.recordAnswer(isCorrect);
        controller.submitExerciseAnswer(isCorrect);
      },
    );
  }

  Widget _buildMicroTaskHard(MicroTaskHardExercise exercise) {
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
