import 'package:dio/dio.dart';
import 'package:news_app/models/article_model.dart';

class NewsService {
  final Dio _dio = Dio();

  Future<List<Article>?> getNews(String apiKey, String theme) async {
    try {
      final response = await _dio.get(
        'https://newsapi.org/v2/everything?q=$theme',
        options: Options(headers: {'X-Api-Key': apiKey}),
      );

      if (response.statusCode == 200) {
        final List<dynamic> articlesJson = response.data['articles'];
        final articles =
            articlesJson.map((json) => Article.fromJson(json)).toList();
        return articles;
      } else if (response.statusCode == 401) {
        return null;
      } else {
        throw Exception('Failed to load news');
      }
    } on DioError catch (error) {
      if (error.response?.statusCode == 401) {
        return null;
      } else {
        throw Exception('Error: ${error.message}');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
