import 'package:flutter/material.dart';
import 'package:my_news/core/utils/common_colors.dart';
import 'package:my_news/domain/entity/news.dart';
import 'package:my_news/presentation/provider/tts_provider.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({super.key, required this.news});
  final News news;

  @override
  Widget build(BuildContext context) {
    DateTime dateObject = DateTime.parse(news.publishedAt!);
    String timeAgo = timeago.format(dateObject);
    return Scaffold(
      backgroundColor: kGreyColor,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Text(
              news.title ?? "",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              // overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            if (news.imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  news.imageUrl!,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error);
                  },
                ),
              ),
            const SizedBox(height: 16),
            Text(
              timeAgo,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              news.description ?? "",
              style: const TextStyle(
                // fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              // overflow: TextOverflow.ellipsis,
            ),
            Consumer<TtsProvider>(builder: (_, provider, __) {
              return GestureDetector(
                onTap: () async {
                  await provider.playText(news.description!);
                },
                child: !provider.isSpeaking
                    ? const Icon(Icons.play_arrow)
                    : const Icon(
                        Icons.pause,
                      ),
              );
            })
          ],
        ),
      ),
    );
  }
}
