import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/user_provider.dart';
import '../widgets/user_tile.dart';

class UserScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return UserTile(user: users[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addUserDialog(context, ref),
        child: Icon(Icons.add),
      ),
    );
  }

  void _addUserDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Add User'),
        content: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
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
              ref.read(userListProvider.notifier).addUser(
                    nameController.text,
                    emailController.text,
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
