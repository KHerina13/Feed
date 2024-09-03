import 'dart:convert';

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;
  late final bool isRead;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
    this.isRead = false,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
      isRead: json['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
      'isRead': isRead,
    };
  }
}
