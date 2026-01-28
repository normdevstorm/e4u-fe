/// Domain model representing a word in the study session.
class StudyWord {
  const StudyWord({
    required this.id,
    required this.english,
    required this.vietnamese,
    this.imageUrl,
    this.videoUrl,
    this.audioUrl,
    required this.contextSentence,
    this.contextSentenceTranslation,
    this.partOfSpeech,
    this.pronunciation,
    this.examples = const [],
  });

  final String id;
  final String english;
  final String vietnamese;
  final String? imageUrl;
  final String? videoUrl;
  final String? audioUrl;
  final String contextSentence;
  final String? contextSentenceTranslation;
  final String? partOfSpeech;
  final String? pronunciation;
  final List<String> examples;

  /// Creates a copy with updated fields
  StudyWord copyWith({
    String? id,
    String? english,
    String? vietnamese,
    String? imageUrl,
    String? videoUrl,
    String? audioUrl,
    String? contextSentence,
    String? contextSentenceTranslation,
    String? partOfSpeech,
    String? pronunciation,
    List<String>? examples,
  }) {
    return StudyWord(
      id: id ?? this.id,
      english: english ?? this.english,
      vietnamese: vietnamese ?? this.vietnamese,
      imageUrl: imageUrl ?? this.imageUrl,
      videoUrl: videoUrl ?? this.videoUrl,
      audioUrl: audioUrl ?? this.audioUrl,
      contextSentence: contextSentence ?? this.contextSentence,
      contextSentenceTranslation:
          contextSentenceTranslation ?? this.contextSentenceTranslation,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      pronunciation: pronunciation ?? this.pronunciation,
      examples: examples ?? this.examples,
    );
  }
}
