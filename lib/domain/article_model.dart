import 'package:json_annotation/json_annotation.dart';

part 'article_model.g.dart';

@JsonSerializable()
class Article {
  final String? title;
  final String? author;
  final Source? source;
  final String? publishedAt;
  final String? url;
  final String? urlToImage;
  final String? description;
  final String? content;
  bool isLiked;

  Article({
    this.title,
    this.author,
    this.source,
    this.publishedAt,
    this.url,
    this.urlToImage,
    this.description,
    this.content,
    this.isLiked = false,
  });

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}

@JsonSerializable()
class Source {
  final String? id;
  final String? name;

  Source({
    this.id,
    this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);
  Map<String, dynamic> toJson() => _$SourceToJson(this);
}
