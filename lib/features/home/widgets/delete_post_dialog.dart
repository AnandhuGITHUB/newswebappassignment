import 'package:flutter/material.dart';

import '../controller/home_controller.dart';
import '../models/article_model.dart';

class DeletePostDialog extends StatelessWidget {
  const DeletePostDialog({
    super.key,
    required HomeController homeController,
    required this.article,
  }) : _homeController = homeController;

  final HomeController _homeController;
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Confirm Deletion',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Are you sure you want to delete this post?',
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancel',
                ),
              ),
              TextButton(
                onPressed: () {
                  _homeController.deletePost(article.id);
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Delete',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
