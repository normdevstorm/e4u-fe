import 'package:flutter/material.dart';
import 'package:e4u_application/app/app.dart';
import 'package:e4u_application/presentation/study/domain/models/study_models.dart';

/// Controller for managing study session state and flow.
/// Handles curriculum selection, unit selection, word preview, and learning flow.
class StudySessionController extends ChangeNotifier {
  StudySessionController();

  // --- State ---
  StudySession? _currentSession;
  StudyUnit? _selectedUnit;
  List<StudyUnit> _availableUnits = [];
  StudyMode _selectedMode = StudyMode.sequential;
  int _committedTimeMinutes = 10;
  bool _isLoading = false;
  String? _errorMessage;

  // --- Getters ---
  StudySession? get currentSession => _currentSession;
  StudyUnit? get selectedUnit => _selectedUnit;
  List<StudyUnit> get availableUnits => _availableUnits;
  List<StudyUnit> get units => _availableUnits; // Alias for compatibility
  StudyMode get selectedMode => _selectedMode;
  int get committedTimeMinutes => _committedTimeMinutes;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  int get wordsToLearn =>
      StudySession.calculateWordsToLearn(_committedTimeMinutes);

  /// Get the current exercise being displayed
  StudyExercise? get currentExercise {
    if (_currentSession == null) return null;
    final index = _currentSession!.currentExerciseIndex;
    if (index >= 0 && index < _currentSession!.exercises.length) {
      return _currentSession!.exercises[index];
    }
    return null;
  }

  // --- Unit Selection ---

  /// Load available units for a curriculum
  Future<void> loadUnits(String curriculumId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 500));
      _availableUnits = _getMockUnits();
    } catch (e) {
      _errorMessage = 'Failed to load units: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Select a unit to study
  void selectUnit(StudyUnit unit) {
    _selectedUnit = unit;
    notifyListeners();
  }

  /// Select a unit by ID
  void selectUnitById(String unitId) {
    final unit = _availableUnits.firstWhere(
      (u) => u.id == unitId,
      orElse: () => _availableUnits.first,
    );
    selectUnit(unit);
  }

  /// Clear selected unit
  void clearSelectedUnit() {
    _selectedUnit = null;
    notifyListeners();
  }

  // --- Mode & Time Settings ---

  /// Set the learning mode (sequential or shuffle)
  void setStudyMode(StudyMode mode) {
    _selectedMode = mode;
    notifyListeners();
  }

  /// Set committed study time in minutes
  void setCommittedTime(int minutes) {
    _committedTimeMinutes = minutes.clamp(5, 60);
    notifyListeners();
  }

  // --- Session Management ---

  /// Start a new study session
  Future<void> startSession() async {
    if (_selectedUnit == null) {
      _errorMessage = 'Please select a unit first';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Get words from unit lessons
      List<StudyWord> words = [];
      for (final lesson in _selectedUnit!.lessons) {
        words.addAll(lesson.words);
      }

      // Limit words based on committed time
      final maxWords = wordsToLearn;
      if (words.length > maxWords) {
        words = words.take(maxWords).toList();
      }

      // Shuffle if needed
      if (_selectedMode == StudyMode.shuffle) {
        words.shuffle();
      }

      // Generate exercises for all phases
      final exercises = _generateExercises(words);

      _currentSession = StudySession(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        unit: _selectedUnit!,
        words: words,
        exercises: exercises,
        mode: _selectedMode,
        currentPhase: StudyPhase.contextualDiscovery,
        startTime: DateTime.now(),
        committedTimeMinutes: _committedTimeMinutes,
        wordsToLearn: words.length,
      );
    } catch (e) {
      _errorMessage = 'Failed to start session: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Generate all exercises for the session
  /// Flow: Contextual Discovery for all words first, then practice exercises for all words
  List<StudyExercise> _generateExercises(List<StudyWord> words) {
    final exercises = <StudyExercise>[];
    int exerciseId = 0;

    // Phase 1: Contextual Discovery - introduce all words first (1 card per word)
    for (final word in words) {
      exercises.add(ContextualDiscoveryExercise(
        id: 'ex_${exerciseId++}',
        targetWord: word,
        cardIndex: 0, // Single discovery card per word
      ));
    }

    // Phase 2: Mechanic Drill - practice all words
    for (final word in words) {
      // Multiple Choice
      exercises.add(MultipleChoiceExercise(
        id: 'ex_${exerciseId++}',
        targetWord: word,
        question: 'What is the meaning of "${word.english}"?',
        options: _generateMultipleChoiceOptions(word, words),
        correctAnswerIndex: 0,
      ));

      // Cloze Exercise
      exercises.add(ClozeExercise(
        id: 'ex_${exerciseId++}',
        targetWord: word,
        sentenceWithBlank: _createClozeFromContext(word),
        correctAnswer: word.english,
        options: _generateClozeOptions(word, words),
      ));

      // Sentence Deconstruction
      exercises.add(SentenceDeconstructionExercise(
        id: 'ex_${exerciseId++}',
        targetWord: word,
        correctSentence: word.contextSentence,
        shuffledParts: _shuffleSentence(word.contextSentence),
      ));
    }

    // Phase 3: Micro Task Output - apply all words
    for (final word in words) {
      // Medium Level
      exercises.add(MicroTaskMediumExercise(
        id: 'ex_${exerciseId++}',
        targetWord: word,
        prompt: 'Complete the sentence using "${word.english}":',
        partialSentence: _createPartialSentence(word),
        expectedCompletion: word.contextSentence,
      ));

      // Hard Level
      exercises.add(MicroTaskHardExercise(
        id: 'ex_${exerciseId++}',
        targetWord: word,
        context: _generateContext(word),
        hints: [word.english, ...word.examples.take(2)],
        simplerVersion: word.contextSentence,
      ));
    }

    return exercises;
  }

  List<String> _generateMultipleChoiceOptions(
    StudyWord correctWord,
    List<StudyWord> allWords,
  ) {
    final options = [correctWord.vietnamese];
    final otherWords = allWords.where((w) => w.id != correctWord.id).toList();
    otherWords.shuffle();

    for (final word in otherWords.take(3)) {
      options.add(word.vietnamese);
    }

    // Ensure we have 4 options
    while (options.length < 4) {
      options.add('Option ${options.length + 1}');
    }

    options.shuffle();
    // Find new correct index after shuffle
    return options;
  }

  List<String> _generateClozeOptions(
    StudyWord correctWord,
    List<StudyWord> allWords,
  ) {
    final options = [correctWord.english];
    final otherWords = allWords.where((w) => w.id != correctWord.id).toList();
    otherWords.shuffle();

    for (final word in otherWords.take(3)) {
      options.add(word.english);
    }

    options.shuffle();
    return options;
  }

  String _createClozeFromContext(StudyWord word) {
    return word.contextSentence.replaceAll(
      RegExp(word.english, caseSensitive: false),
      '_____',
    );
  }

  List<String> _shuffleSentence(String sentence) {
    final parts = sentence.split(' ');
    parts.shuffle();
    return parts;
  }

  String _createPartialSentence(StudyWord word) {
    final parts = word.contextSentence.split(' ');
    if (parts.length > 3) {
      return '${parts.take(2).join(' ')} _____ ${parts.skip(parts.length - 2).join(' ')}';
    }
    return '_____ ${parts.last}';
  }

  String _generateContext(StudyWord word) {
    return 'Create a sentence describing a situation where you would use the word "${word.english}" (${word.vietnamese}).';
  }

  // --- Exercise Flow ---

  /// Move to next exercise
  void nextExercise() {
    if (_currentSession == null) return;

    final nextIndex = _currentSession!.currentExerciseIndex + 1;

    if (nextIndex >= _currentSession!.exercises.length) {
      // Session complete
      _currentSession = _currentSession!.copyWith(
        currentPhase: StudyPhase.completed,
      );
    } else {
      // Determine new phase based on exercise type
      final nextExercise = _currentSession!.exercises[nextIndex];
      final newPhase = _getPhaseForExercise(nextExercise);

      _currentSession = _currentSession!.copyWith(
        currentExerciseIndex: nextIndex,
        currentPhase: newPhase,
      );
    }

    notifyListeners();
  }

  /// Record answer result
  void recordAnswer(bool isCorrect) {
    if (_currentSession == null) return;

    _currentSession = _currentSession!.copyWith(
      correctAnswers: _currentSession!.correctAnswers + (isCorrect ? 1 : 0),
      incorrectAnswers: _currentSession!.incorrectAnswers + (isCorrect ? 0 : 1),
    );

    notifyListeners();
  }

  /// Submit answer for current exercise and move to next
  /// For contextual discovery, pass null to just move to next card
  void submitExerciseAnswer(dynamic answer) {
    if (_currentSession == null) return;

    final exercise = currentExercise;
    if (exercise == null) return;

    // For contextual discovery, no answer to check
    if (exercise.type == ExerciseType.contextualDiscovery) {
      nextExercise();
      return;
    }

    // For other exercises, record the result and move on
    // The widget handles showing feedback before calling this
    nextExercise();
  }

  StudyPhase _getPhaseForExercise(StudyExercise exercise) {
    switch (exercise.type) {
      case ExerciseType.contextualDiscovery:
        return StudyPhase.contextualDiscovery;
      case ExerciseType.multipleChoice:
      case ExerciseType.clozeListenMatch:
      case ExerciseType.sentenceDeconstruction:
        return StudyPhase.mechanicDrill;
      case ExerciseType.microTaskMedium:
      case ExerciseType.microTaskHard:
        return StudyPhase.microTaskOutput;
    }
  }

  /// End current session
  void endSession() {
    _currentSession = null;
    _selectedUnit = null;
    notifyListeners();
  }

  // --- Word Preview Bottom Sheet ---

  /// Show word preview list
  Future<void> showWordPreview(BuildContext context) async {
    if (_selectedUnit == null) return;

    final words = <StudyWord>[];
    for (final lesson in _selectedUnit!.lessons) {
      words.addAll(lesson.words);
    }

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _buildWordPreviewSheet(context, words),
    );
  }

  Widget _buildWordPreviewSheet(BuildContext context, List<StudyWord> words) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: ColorManager.baseWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: ColorManager.grey300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Word Preview',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.grey950,
                  ),
                ),
                Text(
                  '${words.length} words',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: ColorManager.grey500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: words.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final word = words[index];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  title: Text(
                    word.english,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.grey950,
                    ),
                  ),
                  subtitle: Text(
                    word.vietnamese,
                    style: const TextStyle(
                      fontSize: 14,
                      color: ColorManager.grey500,
                    ),
                  ),
                  trailing: word.audioUrl != null
                      ? IconButton(
                          icon: const Icon(Icons.volume_up_rounded),
                          color: ColorManager.purpleHard,
                          onPressed: () {
                            // TODO: Play audio
                          },
                        )
                      : null,
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.purpleHard,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Close',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Mock Data ---
  List<StudyUnit> _getMockUnits() {
    return [
      StudyUnit(
        id: 'unit_1',
        title: 'Basic Greetings',
        description: 'Learn essential greeting phrases',
        estimatedMinutes: 15,
        lessons: [
          StudyLesson(
            id: 'lesson_1_1',
            lessonNumber: 1,
            words: _getMockWords(1, 5),
          ),
          StudyLesson(
            id: 'lesson_1_2',
            lessonNumber: 2,
            words: _getMockWords(6, 5),
          ),
          StudyLesson(
            id: 'lesson_1_3',
            lessonNumber: 3,
            words: _getMockWords(11, 5),
          ),
        ],
      ),
      StudyUnit(
        id: 'unit_2',
        title: 'Common Verbs',
        description: 'Essential action words for daily use',
        estimatedMinutes: 20,
        isLocked: false,
        isCompleted: true,
        lessons: [
          StudyLesson(
            id: 'lesson_2_1',
            lessonNumber: 1,
            words: _getMockWords(16, 5),
          ),
          StudyLesson(
            id: 'lesson_2_2',
            lessonNumber: 2,
            words: _getMockWords(21, 5),
          ),
          StudyLesson(
            id: 'lesson_2_3',
            lessonNumber: 3,
            words: _getMockWords(26, 5),
          ),
        ],
      ),
      const StudyUnit(
        id: 'unit_3',
        title: 'Food & Drinks',
        description: 'Vocabulary for ordering and discussing food',
        estimatedMinutes: 18,
        isLocked: true,
        lessons: [],
      ),
    ];
  }

  List<StudyWord> _getMockWords(int startId, int count) {
    final mockData = [
      ('hello', 'xin chào', 'Hello, how are you today?'),
      ('goodbye', 'tạm biệt', 'Goodbye, see you tomorrow!'),
      ('thank', 'cảm ơn', 'Thank you for your help.'),
      ('please', 'làm ơn', 'Please pass the salt.'),
      ('sorry', 'xin lỗi', 'Sorry for being late.'),
      ('yes', 'vâng', 'Yes, I understand.'),
      ('no', 'không', 'No, I don\'t agree.'),
      ('help', 'giúp đỡ', 'Can you help me?'),
      ('learn', 'học', 'I want to learn English.'),
      ('speak', 'nói', 'I speak Vietnamese.'),
      ('read', 'đọc', 'I like to read books.'),
      ('write', 'viết', 'Please write your name.'),
      ('listen', 'nghe', 'Listen to the music.'),
      ('understand', 'hiểu', 'I understand the lesson.'),
      ('remember', 'nhớ', 'Remember to call me.'),
      ('eat', 'ăn', 'I eat breakfast every morning.'),
      ('drink', 'uống', 'I drink water daily.'),
      ('sleep', 'ngủ', 'I sleep eight hours.'),
      ('work', 'làm việc', 'I work from home.'),
      ('play', 'chơi', 'Children play in the park.'),
      ('go', 'đi', 'I go to school.'),
      ('come', 'đến', 'Please come here.'),
      ('see', 'thấy', 'I see the mountain.'),
      ('know', 'biết', 'I know the answer.'),
      ('think', 'nghĩ', 'I think you are right.'),
      ('want', 'muốn', 'I want to travel.'),
      ('need', 'cần', 'I need your help.'),
      ('like', 'thích', 'I like coffee.'),
      ('love', 'yêu', 'I love my family.'),
      ('make', 'làm', 'I make dinner.'),
    ];

    final words = <StudyWord>[];
    for (int i = 0; i < count && (startId - 1 + i) < mockData.length; i++) {
      final data = mockData[startId - 1 + i];
      words.add(StudyWord(
        id: 'word_${startId + i}',
        english: data.$1,
        vietnamese: data.$2,
        contextSentence: data.$3,
        partOfSpeech: 'verb',
      ));
    }
    return words;
  }
}
