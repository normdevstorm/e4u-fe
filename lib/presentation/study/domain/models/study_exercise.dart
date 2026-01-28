import 'package:e4u_application/presentation/study/domain/models/study_word.dart';

/// Enum representing different types of exercises in the study session.
enum ExerciseType {
  /// Phase 1: Contextual Discovery - Card with English, Vietnamese, media + context
  contextualDiscovery,

  /// Phase 2: Mechanic Drill - Multiple choice question
  multipleChoice,

  /// Phase 2: Mechanic Drill - Cloze/Listen match with blank in sentence
  clozeListenMatch,

  /// Phase 2: Mechanic Drill - Sentence deconstruction
  sentenceDeconstruction,

  /// Phase 3: Micro Task Output - Medium level partial output
  microTaskMedium,

  /// Phase 3: Micro Task Output - Hard level with AI context and hints
  microTaskHard,
}

/// Base class for all study exercises.
abstract class StudyExercise {
  const StudyExercise({
    required this.id,
    required this.type,
    required this.targetWord,
  });

  final String id;
  final ExerciseType type;
  final StudyWord targetWord;
}

/// Phase 1: Contextual Discovery Card Exercise
/// Shows English word, Vietnamese translation, media (video/image), and context sentence.
class ContextualDiscoveryExercise extends StudyExercise {
  const ContextualDiscoveryExercise({
    required super.id,
    required super.targetWord,
    this.cardIndex = 0, // 0, 1, or 2 for the 3x card display
  }) : super(type: ExerciseType.contextualDiscovery);

  final int cardIndex;
}

/// Phase 2: Multiple Choice Exercise
class MultipleChoiceExercise extends StudyExercise {
  const MultipleChoiceExercise({
    required super.id,
    required super.targetWord,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    this.questionType = MultipleChoiceQuestionType.meaningToWord,
  }) : super(type: ExerciseType.multipleChoice);

  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final MultipleChoiceQuestionType questionType;

  String get correctAnswer => options[correctAnswerIndex];
}

enum MultipleChoiceQuestionType {
  /// Given meaning, choose the correct word
  meaningToWord,

  /// Given word, choose the correct meaning
  wordToMeaning,

  /// Given audio, choose the correct word
  audioToWord,
}

/// Phase 2: Cloze/Listen Match Exercise
/// A sentence with a blank that user needs to fill.
class ClozeExercise extends StudyExercise {
  const ClozeExercise({
    required super.id,
    required super.targetWord,
    required this.sentenceWithBlank,
    required this.correctAnswer,
    this.audioUrl,
    this.options = const [],
    this.hasAudio = false,
  }) : super(type: ExerciseType.clozeListenMatch);

  /// Sentence with a blank marker (e.g., "I ___ to the store yesterday.")
  final String sentenceWithBlank;

  /// The correct word to fill in the blank
  final String correctAnswer;

  /// Optional audio URL for listen-and-fill exercises
  final String? audioUrl;

  /// Optional word options for selection (if not free text)
  final List<String> options;

  /// Whether this is an audio-based cloze exercise
  final bool hasAudio;
}

/// Phase 2: Sentence Deconstruction Exercise
/// User reconstructs a sentence from shuffled words/phrases.
class SentenceDeconstructionExercise extends StudyExercise {
  const SentenceDeconstructionExercise({
    required super.id,
    required super.targetWord,
    required this.correctSentence,
    required this.shuffledParts,
  }) : super(type: ExerciseType.sentenceDeconstruction);

  /// The correct sentence to be reconstructed
  final String correctSentence;

  /// Shuffled parts (words or phrases) for user to arrange
  final List<String> shuffledParts;
}

/// Phase 3: Micro Task Output Exercise - Medium Level
/// Partial output where user completes parts of a sentence.
class MicroTaskMediumExercise extends StudyExercise {
  const MicroTaskMediumExercise({
    required super.id,
    required super.targetWord,
    required this.prompt,
    required this.partialSentence,
    required this.expectedCompletion,
  }) : super(type: ExerciseType.microTaskMedium);

  /// The prompt/context for the exercise
  final String prompt;

  /// The partial sentence with blanks
  final String partialSentence;

  /// The expected completion pattern
  final String expectedCompletion;
}

/// Phase 3: Micro Task Output Exercise - Hard Level
/// AI provides context with hints, user forms a complete sentence.
class MicroTaskHardExercise extends StudyExercise {
  const MicroTaskHardExercise({
    required super.id,
    required super.targetWord,
    required this.context,
    required this.hints,
    required this.simplerVersion,
    this.expectedPatterns = const [],
  }) : super(type: ExerciseType.microTaskHard);

  /// AI-generated context describing the situation
  final String context;

  /// Hint words to guide the user
  final List<String> hints;

  /// A simpler version of the expected sentence
  final String simplerVersion;

  /// Expected sentence patterns for validation
  final List<String> expectedPatterns;
}
