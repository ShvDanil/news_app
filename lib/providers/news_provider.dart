import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';

class NewsProvider extends ChangeNotifier {
  List<Article> _articles = [];
  List<Article> get articles => _articles;

  void setArticles(List<Article> articles) {
    if (_articles != articles) {
      _articles = articles;
      notifyListeners();
    }
  }
}
