import 'package:news_app/domain/article_model.dart';

abstract class NewsRepository {
  Future<List<Article>?> getNews(String apiKey, String theme);
}
