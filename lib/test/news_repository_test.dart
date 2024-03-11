import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/domain/news_repository_impl.dart';
import 'package:news_app/domain/news_repository.dart';
import 'package:news_app/domain/article_model.dart';

void main() {
  group('NewsRepository tests', () {
    late NewsRepository newsRepository;
    late Dio dio;

    setUp(() {
      dio = Dio(
        BaseOptions(
          baseUrl: 'https://newsapi.org',
        ),
      );
      newsRepository = NewsRepositoryImpl(dio);
    });

    test('getNews success', () async {
      const apiKey = 'a0bd7b3d69c64d3780be01d584e81efc';
      const theme = 'apple';

      final result = await newsRepository.getNews(apiKey, theme);

      expect(result, isA<List<Article>>());
      expect(result?.isNotEmpty, true);
    });

    test('getNews failure', () async {
      const apiKey = 'a0bd7b3d69c64d3780be01d584e81efcысвдл'; // wrong api key
      const theme = 'apple1'; // wrong query theme

      expect(() => newsRepository.getNews(apiKey, theme), throwsException);
    });
  });
}
