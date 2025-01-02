import 'package:flutter/material.dart';
import '../models/post.dart';
import '../screens/comment_screen.dart';

class PostTile extends StatelessWidget {
  final Post post;

  PostTile({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(post.title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(post.content),
        trailing: Icon(Icons.comment),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CommentScreen(postId: post.id),
            ),
          );
        },
      ),
    );
  }
}
