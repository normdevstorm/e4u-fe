import 'package:e4u_application/presentation/study/domain/models/study_word.dart';

/// Domain model representing a lesson/unit in the study curriculum.
/// Each lesson contains multiple parts, with 5 words per part.
class StudyLesson {
  const StudyLesson({
    required this.id,
    required this.title,
    required this.description,
    required this.parts,
    this.thumbnailUrl,
    this.estimatedMinutes,
    this.isCompleted = false,
    this.isLocked = false,
    this.progress = 0.0,
  });

  final String id;
  final String title;
  final String description;
  final List<StudyLessonPart> parts;
  final String? thumbnailUrl;
  final int? estimatedMinutes;
  final bool isCompleted;
  final bool isLocked;
  final double progress; // 0.0 to 1.0

  /// Total words in this lesson
  int get totalWords => parts.fold(0, (sum, part) => sum + part.words.length);

  /// Total parts in this lesson (typically 3)
  int get totalParts => parts.length;

  StudyLesson copyWith({
    String? id,
    String? title,
    String? description,
    List<StudyLessonPart>? parts,
    String? thumbnailUrl,
    int? estimatedMinutes,
    bool? isCompleted,
    bool? isLocked,
    double? progress,
  }) {
    return StudyLesson(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      parts: parts ?? this.parts,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
      isCompleted: isCompleted ?? this.isCompleted,
      isLocked: isLocked ?? this.isLocked,
      progress: progress ?? this.progress,
    );
  }
}

/// A part within a lesson, containing 5 words each.
class StudyLessonPart {
  const StudyLessonPart({
    required this.id,
    required this.partNumber,
    required this.words,
    this.isCompleted = false,
  });

  final String id;
  final int partNumber;
  final List<StudyWord> words;
  final bool isCompleted;

  StudyLessonPart copyWith({
    String? id,
    int? partNumber,
    List<StudyWord>? words,
    bool? isCompleted,
  }) {
    return StudyLessonPart(
      id: id ?? this.id,
      partNumber: partNumber ?? this.partNumber,
      words: words ?? this.words,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
