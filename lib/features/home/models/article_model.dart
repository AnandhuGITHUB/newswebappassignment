import 'package:cloud_firestore/cloud_firestore.dart';

class Article {
  final String id;
  final String title;
  final String content;
  final String author;
  final Timestamp timestamp;

  Article({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.timestamp,
  });

  factory Article.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Article(
      id: doc.id,
      title: data['title'],
      content: data['content'],
      author: data['author'],
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }
}
