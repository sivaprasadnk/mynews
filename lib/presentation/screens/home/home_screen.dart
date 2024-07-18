import 'package:flutter/material.dart';
import 'package:news_app/core/utils/common_colors.dart';
import 'package:news_app/core/utils/common_strings.dart';
import 'package:news_app/presentation/provider/firebase_provider.dart';
import 'package:news_app/presentation/provider/news_provider.dart';
import 'package:news_app/presentation/widgets/loading_shimmer.dart';
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
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Consumer<FirebaseProvider>(
            builder: (_, provider, __) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.navigation_rounded, color: kWhiteColor),
                  const SizedBox(width: 5),
                  Text(
                    provider.countryCode.toUpperCase(),
                    style: TextStyle(
                      color: kWhiteColor,
                    ),
                  )
                ],
              );
            },
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: () async {
              await context.read<FirebaseProvider>().signOutUser(context);
            },
            child: Icon(
              Icons.logout,
              color: kWhiteColor,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          var code = context.read<FirebaseProvider>().countryCode;
          context.read<NewsProvider>().fetchNews(code);
        },
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 16,
                left: 16,
              ),
              child: Text(
                'Top Headlines',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              child: NewsList(),
            ),
          ],
        ),
      ),
    );
  }
}

class NewsList extends StatelessWidget {
  const NewsList({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Consumer<NewsProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return LoadingList(width: width);
          // return const Center(child: CircularProgressIndicator());
        } else if (provider.message != null) {
          return Center(child: Text(provider.message!));
        } else {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.news?.length ?? 0,
            itemBuilder: (context, index) {
              final newsItem = provider.news![index];
              return newsItem.title!.isNotEmpty &&
                      newsItem.description!.isNotEmpty &&
                      newsItem.title != "[Removed]"
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
                            width: width * 0.55,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: width * 0.6,
                                  child: Text(
                                    newsItem.title ?? "",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                SizedBox(
                                  width: width * 0.55,
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
                          const Spacer(),
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
                          else
                            Container(
                              height: 109,
                              width: 109,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: kBlueColor,
                                ),
                              ),
                              child: const Center(
                                child: Text(" No Image"),
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

class LoadingList extends StatelessWidget {
  const LoadingList({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
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
                width: width * 0.55,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width * 0.6,
                      child: LoadingShimmer.rectangle(
                        height: 20,
                        width: width * .55,
                        context: context,
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: width * 0.55,
                      child: LoadingShimmer.rectangle(
                        height: 20,
                        width: width * .55,
                        context: context,
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LoadingShimmer.rectangle(
                  height: 109,
                  width: 109,
                  context: context,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
