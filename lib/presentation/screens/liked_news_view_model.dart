import 'package:news_app/presentation/providers/liked_news_interactor.dart';

class LikedNewsViewModel {
  final LikedNewsInteractor _interactor;

  LikedNewsViewModel(this._interactor);

  Future<List<int>> loadLikedArticles() async {
    return _interactor.loadLikedArticles();
  }

  void removeLikedArticle(int articleIndex) {
    _interactor.removeLikedArticle(articleIndex);
  }
}
