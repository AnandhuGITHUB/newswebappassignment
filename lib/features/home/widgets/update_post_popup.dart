// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:news_feed_web_app/core/theme/app_palette.dart';

import '../../../widgets/app_text_field.dart';
import '../controller/home_controller.dart';
import '../models/article_model.dart';

class UpdatePostPopup extends StatefulWidget {
  final Article article;
  const UpdatePostPopup({
    super.key,
    required this.article,
  });

  @override
  State<UpdatePostPopup> createState() => _UpdatePostPopupState();
}

class _UpdatePostPopupState extends State<UpdatePostPopup> {
  final HomeController _homeController = Get.find();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  @override
  void initState() {
    _titleController.text = widget.article.title;
    _contentController.text = widget.article.content;
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "Edit News Article",
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
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel'),
        ),
        Obx(
          () => _homeController.isLoading.value
              ? const CircularProgressIndicator(
                  color: AppPalette.gradient2,
                )
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppPalette.gradient2,
                  ),
                  onPressed: () async {
                    String title = _titleController.text.trim();
                    String content = _contentController.text.trim();

                    await _homeController.editPost(
                        widget.article.id, title, content);

                    _titleController.clear();
                    _contentController.clear();
                  },
                  child: const Text('Update Post'),
                ),
        )
      ],
    );
  }
}
