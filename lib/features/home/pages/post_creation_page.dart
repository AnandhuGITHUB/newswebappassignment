import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_feed_web_app/widgets/app_button.dart';
import 'package:news_feed_web_app/widgets/app_text_field.dart';
import '../../../core/theme/app_palette.dart';
import '../controller/home_controller.dart';

class PostCreationPage extends StatefulWidget {
  const PostCreationPage({super.key});

  @override
  State<PostCreationPage> createState() => _PostCreationPageState();
}

class _PostCreationPageState extends State<PostCreationPage> {
  final HomeController _homeController = Get.find();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _authorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(title: const Text('Create Post')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Text(
                  "Create New News Article",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                AppTextField(
                  controller: _titleController,
                  hintText: 'Title',
                ),
                const SizedBox(height: 15),
                AppTextField(
                  controller: _contentController,
                  hintText: 'News Content',
                  maxLines: 10,
                ),
                const SizedBox(height: 15),
                AppTextField(
                  controller: _authorController,
                  hintText: 'Author Name',
                ),
                const SizedBox(height: 20),
                Obx(
                  () => _homeController.isLoading.value
                      ? const CircularProgressIndicator(
                          color: AppPalette.gradient2,
                        )
                      : AppButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              String title = _titleController.text.trim();
                              String content = _contentController.text.trim();
                              String author = _authorController.text.trim();

                              await _homeController.createPost(
                                  title, content, author);

                              _titleController.clear();
                              _contentController.clear();
                              _authorController.clear();
                            }
                          },
                          buttonText: 'Create Post',
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
