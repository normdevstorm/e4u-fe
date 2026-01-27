import 'package:e4u_application/domain/learning/repositories/learning_repository.dart';

import '../api/learning_api.dart';

class LearningRepositoryImpl implements LearningRepository {
  final LearningApi api;

  LearningRepositoryImpl(this.api);
}
