import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'learning_api.g.dart';

@RestApi()
abstract class LearningApi {
  factory LearningApi(Dio dio, {String baseUrl}) = _LearningApi;
}
