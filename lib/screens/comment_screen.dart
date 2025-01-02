import 'package:flutter/material.dart';
import 'package:flutter_comments/widgets/comment_tail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/comment_provider.dart';

class CommentScreen extends ConsumerWidget {
  final String postId;

  CommentScreen({required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final comments = ref.watch(commentListProvider)
        .where((comment) => comment.postId == postId)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: ListView.builder(
        itemCount: comments.length,
        itemBuilder: (context, index) {
          return CommentTile(comment: comments[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addCommentDialog(context, ref),
        child: Icon(Icons.add),
      ),
    );
  }

  void _addCommentDialog(BuildContext context, WidgetRef ref) {
    final contentController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Add Comment'),
        content: TextField(
          controller: contentController,
          decoration: InputDecoration(labelText: 'Comment'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(commentListProvider.notifier).addComment(
                    postId,
                    contentController.text,
                  );
              Navigator.of(ctx).pop();
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }
}
