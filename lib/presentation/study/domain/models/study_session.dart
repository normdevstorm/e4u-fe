import 'package:e4u_application/presentation/study/domain/models/study_exercise.dart';
import 'package:e4u_application/presentation/study/domain/models/study_unit.dart';
import 'package:e4u_application/presentation/study/domain/models/study_word.dart';

/// Enum for learning mode selection.
enum StudyMode {
  /// Words are presented in order
  sequential,

  /// Words are presented in random order
  shuffle,
}

/// Enum for current study phase.
enum StudyPhase {
  /// Phase 1: Contextual Discovery (3x cards per word)
  contextualDiscovery,

  /// Phase 2: Mechanic Drill (multiple choice, cloze, deconstruction)
  mechanicDrill,

  /// Phase 3: Micro Task Output (medium and hard levels)
  microTaskOutput,

  /// Session completed
  completed,
}

/// Represents the current state of a study session.
class StudySession {
  const StudySession({
    required this.id,
    required this.unit,
    required this.words,
    required this.exercises,
    this.mode = StudyMode.sequential,
    this.currentPhase = StudyPhase.contextualDiscovery,
    this.currentWordIndex = 0,
    this.currentExerciseIndex = 0,
    this.contextualDiscoveryCardIndex = 0,
    this.correctAnswers = 0,
    this.incorrectAnswers = 0,
    this.startTime,
    this.committedTimeMinutes = 10,
    this.wordsToLearn = 5,
  });

  final String id;
  final StudyUnit unit;
  final List<StudyWord> words;
  final List<StudyExercise> exercises;
  final StudyMode mode;
  final StudyPhase currentPhase;
  final int currentWordIndex;
  final int currentExerciseIndex;
  final int contextualDiscoveryCardIndex; // 0, 1, 2 for the 3x cards
  final int correctAnswers;
  final int incorrectAnswers;
  final DateTime? startTime;
  final int committedTimeMinutes;
  final int wordsToLearn;

  /// Current word being studied
  StudyWord? get currentWord =>
      currentWordIndex < words.length ? words[currentWordIndex] : null;

  /// Current exercise
  StudyExercise? get currentExercise => currentExerciseIndex < exercises.length
      ? exercises[currentExerciseIndex]
      : null;

  /// Total exercises in session
  int get totalExercises => exercises.length;

  /// Progress percentage (0.0 to 1.0)
  double get progress =>
      totalExercises > 0 ? currentExerciseIndex / totalExercises : 0.0;

  /// Accuracy percentage
  double get accuracy {
    final total = correctAnswers + incorrectAnswers;
    return total > 0 ? correctAnswers / total : 0.0;
  }

  /// Check if session is complete
  bool get isComplete => currentPhase == StudyPhase.completed;

  /// Calculate words to learn based on committed time
  /// Approximately 2 minutes per word for full learning cycle
  static int calculateWordsToLearn(int committedMinutes) {
    const minutesPerWord = 2;
    final words = (committedMinutes / minutesPerWord).floor();
    return words.clamp(3, 15); // Min 3, max 15 words per session
  }

  StudySession copyWith({
    String? id,
    StudyUnit? unit,
    List<StudyWord>? words,
    List<StudyExercise>? exercises,
    StudyMode? mode,
    StudyPhase? currentPhase,
    int? currentWordIndex,
    int? currentExerciseIndex,
    int? contextualDiscoveryCardIndex,
    int? correctAnswers,
    int? incorrectAnswers,
    DateTime? startTime,
    int? committedTimeMinutes,
    int? wordsToLearn,
  }) {
    return StudySession(
      id: id ?? this.id,
      unit: unit ?? this.unit,
      words: words ?? this.words,
      exercises: exercises ?? this.exercises,
      mode: mode ?? this.mode,
      currentPhase: currentPhase ?? this.currentPhase,
      currentWordIndex: currentWordIndex ?? this.currentWordIndex,
      currentExerciseIndex: currentExerciseIndex ?? this.currentExerciseIndex,
      contextualDiscoveryCardIndex:
          contextualDiscoveryCardIndex ?? this.contextualDiscoveryCardIndex,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      incorrectAnswers: incorrectAnswers ?? this.incorrectAnswers,
      startTime: startTime ?? this.startTime,
      committedTimeMinutes: committedTimeMinutes ?? this.committedTimeMinutes,
      wordsToLearn: wordsToLearn ?? this.wordsToLearn,
    );
  }
}
