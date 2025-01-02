import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/comment.dart';

part 'comment_provider.g.dart';

@riverpod
class CommentList extends _$CommentList {
  @override
  List<Comment> build() {
    final box = Hive.box('app_data');
    // Hive'dan commentlarni yuklash va List<Comment> formatiga o'tkazish
    final comments = (box.get('comments', defaultValue: []) as List)
        .map((comment) => Comment.fromJson(comment as Map<String, dynamic>))
        .toList();
    return comments;
  }

  // Komment qo'shish
  void addComment(String postId, String content) {
    final comment = Comment(
      id: DateTime.now().toString(),
      postId: postId,
      content: content,
    );
    state = [...state, comment];

    // Yangi commentlar ro'yxatini Hive'ga saqlash
    final box = Hive.box('app_data');
    box.put('comments', state.map((comment) => comment.toJson()).toList());
  }

  // Kommentni o'chirish
  void removeComment(String id) {
    state = state.where((comment) => comment.id != id).toList();

    // O'zgartirilgan commentlar ro'yxatini Hive'ga qayta yozish
    final box = Hive.box('app_data');
    box.put('comments', state.map((comment) => comment.toJson()).toList());
  }
}
