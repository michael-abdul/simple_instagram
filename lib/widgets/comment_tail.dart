import 'package:flutter/material.dart';
import '../models/comment.dart';

class CommentTile extends StatelessWidget {
  final Comment comment;

  CommentTile({required this.comment});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(comment.content),
      ),
    );
  }
}
