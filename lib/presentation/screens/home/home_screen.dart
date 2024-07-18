import 'package:flutter/material.dart';
import 'package:news_app/core/utils/common_colors.dart';
import 'package:news_app/core/utils/common_strings.dart';
import 'package:news_app/presentation/provider/firebase_provider.dart';
import 'package:news_app/presentation/provider/news_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreyColor,
      appBar: AppBar(
        backgroundColor: kBlueColor,
        title: Text(
          kAppName,
          style: TextStyle(
            color: kWhiteColor,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              await context.read<FirebaseProvider>().signOutUser(context);
            },
            child: Icon(
              Icons.logout,
              color: kWhiteColor,
            ),
          )
        ],
      ),
      body: const NewsList(),
    );
  }
}

class NewsList extends StatelessWidget {
  const NewsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (provider.message != null) {
          return Center(child: Text(provider.message!));
        } else {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.news?.length ?? 0,
            itemBuilder: (context, index) {
              final newsItem = provider.news![index];
              return newsItem.title!.isNotEmpty &&
                      newsItem.description!.isNotEmpty
                  ? Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kWhiteColor,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Text(
                                    newsItem.title ?? "",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  // height: 100,
                                  child: Text(
                                    newsItem.description ?? "",
                                    style: const TextStyle(),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                          ),
                          if (newsItem.imageUrl != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                newsItem.imageUrl!,
                                height: 109,
                                width: 109,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.error);
                                },
                              ),
                            )
                        ],
                      ),
                    )
                  : const SizedBox.shrink();
            },
          );
        }
      },
    );
  }
}
