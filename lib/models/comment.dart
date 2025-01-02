import 'dart:convert';

class Comment {
  final String id;
  final String postId;
  final String content;

  Comment({
    required this.id,
    required this.postId,
    required this.content,
  });

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'postId': postId,
      'content': content,
    };
  }

  // From JSON
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      postId: json['postId'],
      content: json['content'],
    );
  }

  // Copy With
  Comment copyWith({
    String? id,
    String? postId,
    String? content,
  }) {
    return Comment(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      content: content ?? this.content,
    );
  }

  @override
  String toString() => 'Comment(id: $id, postId: $postId, content: $content)';
}
