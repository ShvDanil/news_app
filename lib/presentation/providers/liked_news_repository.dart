abstract class LikedNewsRepository {
  Future<List<int>> loadLikedArticles();
  Future<void> saveLikedArticles(List<int> likedArticles);
}
