import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/user.dart';

part 'user_provider.g.dart';

@riverpod
class UserList extends _$UserList {
  @override
  List<User> build() {
    final box = Hive.box('app_data');
    
    // Foydalanuvchilarni yuklash va dynamic'ni User tipiga aylantirish
    final users = (box.get('users', defaultValue: []) as List)
        .map((user) => User.fromJson(user as Map<String, dynamic>))
        .toList();
    return users;
  }

  // Foydalanuvchi qo'shish
  void addUser(String name, String email) {
    final user = User(
      id: DateTime.now().toString(),
      name: name,
      email: email,
    );
    state = [...state, user];

    // Yangi ro'yxatni Hive'ga saqlash
    final box = Hive.box('app_data');
    box.put('users', state.map((user) => user.toJson()).toList());
  }

  // Foydalanuvchini o'chirish
  void removeUser(String id) {
    state = state.where((user) => user.id != id).toList();

    // O'zgartirilgan ro'yxatni Hive'ga qayta yozish
    final box = Hive.box('app_data');
    box.put('users', state.map((user) => user.toJson()).toList());
  }
}
