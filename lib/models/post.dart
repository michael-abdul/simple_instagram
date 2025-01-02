import 'dart:convert';

class Post {
  final String id;
  final String userId;
  final String title;
  final String content;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
  });

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'content': content,
    };
  }

  // From JSON
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      content: json['content'],
    );
  }

  // Copy With
  Post copyWith({
    String? id,
    String? userId,
    String? title,
    String? content,
  }) {
    return Post(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }

  @override
  String toString() =>
      'Post(id: $id, userId: $userId, title: $title, content: $content)';
}
