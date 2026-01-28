/// Domain model representing a curriculum in the learning system.
/// Each curriculum contains multiple lessons organized in modules.
class CurriculumModel {
  const CurriculumModel({
    required this.id,
    required this.title,
    required this.description,
    required this.author,
    required this.lessonCount,
    required this.totalDuration,
    this.thumbnailUrl,
    this.isCurrent = false,
    this.progress = 0.0,
  });

  final String id;
  final String title;
  final String description;
  final String author;
  final int lessonCount;
  final String totalDuration; // e.g., "4h 30m"
  final String? thumbnailUrl;
  final bool isCurrent; // Is this the user's current active curriculum
  final double progress; // 0.0 to 1.0

  /// Get formatted progress percentage string
  String get progressPercentage => '${(progress * 100).toInt()}%';

  CurriculumModel copyWith({
    String? id,
    String? title,
    String? description,
    String? author,
    int? lessonCount,
    String? totalDuration,
    String? thumbnailUrl,
    bool? isCurrent,
    double? progress,
  }) {
    return CurriculumModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      author: author ?? this.author,
      lessonCount: lessonCount ?? this.lessonCount,
      totalDuration: totalDuration ?? this.totalDuration,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      isCurrent: isCurrent ?? this.isCurrent,
      progress: progress ?? this.progress,
    );
  }

  /// Mock data for development
  static List<CurriculumModel> mockCurriculums() {
    return [
      const CurriculumModel(
        id: 'curr_1',
        title: 'English Fundamentals',
        description: 'Master the basics of English grammar and vocabulary',
        author: 'E4U AI',
        lessonCount: 24,
        totalDuration: '6h 30m',
        isCurrent: true,
        progress: 0.45,
      ),
      const CurriculumModel(
        id: 'curr_2',
        title: 'Business English',
        description: 'Professional communication for workplace success',
        author: 'E4U AI',
        lessonCount: 18,
        totalDuration: '5h 00m',
        progress: 0.20,
      ),
      const CurriculumModel(
        id: 'curr_3',
        title: 'IELTS Preparation',
        description: 'Comprehensive guide to IELTS exam preparation',
        author: 'E4U AI',
        lessonCount: 32,
        totalDuration: '10h 00m',
        progress: 0.0,
      ),
      const CurriculumModel(
        id: 'curr_4',
        title: 'Conversational English',
        description: 'Everyday speaking skills and common expressions',
        author: 'E4U AI',
        lessonCount: 20,
        totalDuration: '4h 30m',
        progress: 0.65,
      ),
    ];
  }
}
