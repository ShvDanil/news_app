import 'package:get_it/get_it.dart';
import 'package:news_app/domain/news_repository.dart';
import 'package:news_app/domain/news_repository_impl.dart';
import 'package:news_app/presentation/providers/liked_news_interactor.dart';
import 'package:news_app/presentation/providers/liked_news_repository.dart';
import 'package:news_app/presentation/providers/liked_news_repository_impl.dart';
import 'package:news_app/domain/news_interactor.dart';
import 'package:news_app/presentation/providers/news_provider.dart';
import 'package:dio/dio.dart';

class DiContainer {
  static final GetIt _locator = GetIt.instance;

  static void setup() {
    _locator.registerLazySingleton<LikedNewsRepository>(
        () => LikedNewsRepositoryImpl());
    _locator.registerLazySingleton(
        () => LikedNewsInteractor(_locator<LikedNewsRepository>()));

    _locator
        .registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl(Dio()));
    _locator.registerLazySingleton(
        () => NewsInteractor(_locator<NewsRepository>()));

    _locator.registerLazySingleton<NewsProvider>(() => NewsProvider());
  }

  static T get<T extends Object>() {
    return _locator<T>();
  }
}
