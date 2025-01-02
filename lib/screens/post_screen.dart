import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/post_provider.dart';
import '../providers/user_provider.dart';
import '../widgets/post_tile.dart';

class PostScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(postListProvider);
    final users = ref.watch(userListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostTile(post: posts[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addPostDialog(context, ref, users),
        child: Icon(Icons.add),
      ),
    );
  }

  void _addPostDialog(BuildContext context, WidgetRef ref, List users) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    String? selectedUser;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Add Post'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              items: users.map<DropdownMenuItem<String>>((user) {
                return DropdownMenuItem<String>(
                  value: user.id,
                  child: Text(user.name),
                );
              }).toList(),
              onChanged: (value) {
                selectedUser = value;
              },
              decoration: InputDecoration(labelText: 'Select User'),
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: 'Content'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (selectedUser != null) {
                ref.read(postListProvider.notifier).addPost(
                      selectedUser!,
                      titleController.text,
                      contentController.text,
                    );
                Navigator.of(ctx).pop();
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }
}
