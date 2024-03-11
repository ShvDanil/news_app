import 'package:shared_preferences/shared_preferences.dart';
import 'package:news_app/presentation/providers/liked_news_repository.dart';

class LikedNewsRepositoryImpl extends LikedNewsRepository {
  @override
  Future<List<int>> loadLikedArticles() async {
    final prefs = await SharedPreferences.getInstance();
    final likedArticlesStringList = prefs.getStringList('likedArticles');
    if (likedArticlesStringList != null) {
      return likedArticlesStringList.map((e) => int.parse(e)).toList();
    } else {
      return [];
    }
  }

  @override
  Future<void> saveLikedArticles(List<int> likedArticles) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        'likedArticles', likedArticles.map((e) => e.toString()).toList());
  }
}
