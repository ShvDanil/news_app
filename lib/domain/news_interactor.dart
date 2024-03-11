import 'package:news_app/domain/article_model.dart';
import 'package:news_app/domain/news_repository.dart';

class NewsInteractor {
  final NewsRepository _newsRepository;

  NewsInteractor(this._newsRepository);

  Future<List<Article>?> getNews(String apiKey, String theme) {
    return _newsRepository.getNews(apiKey, theme);
  }
}
