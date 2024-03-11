import 'package:flutter/material.dart';
import 'package:news_app/presentation/providers/liked_news_repository.dart';

class LikedNewsInteractor extends ChangeNotifier {
  final LikedNewsRepository _repository;
  List<int> likedArticles = [];

  LikedNewsInteractor(this._repository) {
    _loadLikedArticles();
  }

  void addLikedArticle(int articleIndex) {
    likedArticles.insert(0, articleIndex);
    _saveLikedArticles();
    notifyListeners();
  }

  void removeLikedArticle(int articleIndex) {
    likedArticles.remove(articleIndex);
    _saveLikedArticles();
    notifyListeners();
  }

  Future<void> _saveLikedArticles() async {
    await _repository.saveLikedArticles(likedArticles);
  }

  Future<List<int>> _loadLikedArticles() async {
    final loadedArticles = await _repository.loadLikedArticles();
    likedArticles = loadedArticles;
    return loadedArticles;
  }

  Future<List<int>> loadLikedArticles() async {
    final loadedArticles = await _loadLikedArticles();
    notifyListeners();
    return loadedArticles;
  }

  Future<void> saveLikedArticles() async {
    await _saveLikedArticles();
    notifyListeners();
  }
}
