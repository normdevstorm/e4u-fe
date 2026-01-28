import 'package:e4u_application/presentation/study/domain/models/study_word.dart';

/// Domain model representing a unit in the study curriculum.
/// Each unit contains multiple lessons, with 5 words per lesson.
class StudyUnit {
  const StudyUnit({
    required this.id,
    required this.title,
    required this.description,
    required this.lessons,
    this.thumbnailUrl,
    this.estimatedMinutes,
    this.isCompleted = false,
    this.isLocked = false,
    this.progress = 0.0,
  });

  final String id;
  final String title;
  final String description;
  final List<StudyLesson> lessons;
  final String? thumbnailUrl;
  final int? estimatedMinutes;
  final bool isCompleted;
  final bool isLocked;
  final double progress; // 0.0 to 1.0

  /// Total words in this unit
  int get totalWords =>
      lessons.fold(0, (sum, lesson) => sum + lesson.words.length);

  /// Total lessons in this unit (typically 3)
  int get totalLessons => lessons.length;

  StudyUnit copyWith({
    String? id,
    String? title,
    String? description,
    List<StudyLesson>? lessons,
    String? thumbnailUrl,
    int? estimatedMinutes,
    bool? isCompleted,
    bool? isLocked,
    double? progress,
  }) {
    return StudyUnit(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      lessons: lessons ?? this.lessons,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
      isCompleted: isCompleted ?? this.isCompleted,
      isLocked: isLocked ?? this.isLocked,
      progress: progress ?? this.progress,
    );
  }
}

/// A lesson within a unit, containing 5 words each.
class StudyLesson {
  const StudyLesson({
    required this.id,
    required this.lessonNumber,
    required this.words,
    this.isCompleted = false,
  });

  final String id;
  final int lessonNumber;
  final List<StudyWord> words;
  final bool isCompleted;

  StudyLesson copyWith({
    String? id,
    int? lessonNumber,
    List<StudyWord>? words,
    bool? isCompleted,
  }) {
    return StudyLesson(
      id: id ?? this.id,
      lessonNumber: lessonNumber ?? this.lessonNumber,
      words: words ?? this.words,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
