import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_feed_web_app/features/home/controller/home_controller.dart';
import 'package:news_feed_web_app/core/theme/app_palette.dart';
import 'package:news_feed_web_app/features/home/widgets/logout_confirmation.dart';
import 'package:news_feed_web_app/utils/formatter.dart';

import '../widgets/delete_post_dialog.dart';
import '../widgets/news_expanded_dialog.dart';
import '../widgets/update_post_popup.dart';
import 'post_creation_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Latest News Feed'),
        actions: [
          Obx(
            () => IconButton(
              icon: _homeController.themeMode == ThemeMode.dark
                  ? const Icon(Icons.light_mode)
                  : const Icon(Icons.dark_mode),
              onPressed: () {
                _homeController.toggleThemeMode();
              },
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: const LogoutConfirmation(),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (_homeController.articles.isEmpty) {
            return const Center(
              child: Text('No articles available.'),
            );
          }
          return Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: ListView.separated(
                itemCount: _homeController.articles.length,
                separatorBuilder: (context, index) => const SizedBox(
                  height: 15,
                ),
                itemBuilder: (context, index) {
                  final article = _homeController.articles[index];
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: NewsExpandedDialog(
                                article: article,
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Card(
                      elevation: 5,
                      margin: EdgeInsets.zero,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xffB0B0B0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 5,
                                right: 8,
                                left: 8,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      article.title,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1,
                                        color: AppPalette.darkBackgroundColor,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Dialog(
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.2,
                                                  child: DeletePostDialog(
                                                    homeController:
                                                        _homeController,
                                                    article: article,
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: AppPalette.errorColor,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Get.dialog(
                                            UpdatePostPopup(
                                              article: article,
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const Divider(),
                            const SizedBox(height: 10),
                            Text(
                              '${article.content} ',
                              overflow: TextOverflow.fade,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                letterSpacing: 0.5,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              'News Article by ${article.author} ',
                              overflow: TextOverflow.clip,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                                height: 1.3,
                              ),
                            ),
                            Text(
                              'Posted on ${Formatter.formatTimestamp(article.timestamp)} ',
                              overflow: TextOverflow.clip,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Create Post'),
        backgroundColor: AppPalette.gradient2,
        onPressed: () {
          Get.to(() => const PostCreationPage());
        },
        icon: const Icon(Icons.add),
      ),
    );
  }
}
