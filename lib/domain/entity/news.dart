import 'package:equatable/equatable.dart';

class News extends Equatable {
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? publishedAt;

  const News({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.publishedAt,
  });

  @override
  List<Object?> get props => [
        title,
        description,
        imageUrl,
        publishedAt,
      ];
}
