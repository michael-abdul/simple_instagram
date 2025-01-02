import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/post.dart';

part 'post_provider.g.dart';

@riverpod
class PostList extends _$PostList {
  @override
  List<Post> build() {
    final box = Hive.box('app_data');
    // Hive'dan postlarni yuklash va List<Post> formatiga o'tkazish
    final posts = (box.get('posts', defaultValue: []) as List)
        .map((post) => Post.fromJson(post as Map<String, dynamic>))
        .toList();
    return posts;
  }

  // Post qo'shish
  void addPost(String userId, String title, String content) {
    final post = Post(
      id: DateTime.now().toString(),
      userId: userId,
      title: title,
      content: content,
    );
    state = [...state, post];

    // Yangi postlar ro'yxatini Hive'ga saqlash
    final box = Hive.box('app_data');
    box.put('posts', state.map((post) => post.toJson()).toList());
  }

  // Postni o'chirish
  void removePost(String id) {
    state = state.where((post) => post.id != id).toList();

    // O'zgartirilgan postlar ro'yxatini Hive'ga qayta yozish
    final box = Hive.box('app_data');
    box.put('posts', state.map((post) => post.toJson()).toList());
  }
}
