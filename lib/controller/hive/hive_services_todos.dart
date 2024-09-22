import 'package:hive/hive.dart';
import '../../model/user_data/user_data.dart';

class HiveServicesTodos {
  Future<void> openUserBox() async {
    Box<dynamic>? userBox;
    // ignore: unnecessary_null_comparison
    if (userBox == null || !userBox.isOpen) {
      String? userBoxName = await getUserBox();
      if (userBoxName != null) {
        userBox = await Hive.openBox(userBoxName);
      }
    }
  }

  Future<bool> storeTodos(UserData userData) async {
    String? userBoxName = await getUserBox();

    var userBox = await Hive.openBox(userBoxName!);
    List<dynamic> retrieveduserTodos =
        await userBox.get("userData", defaultValue: []) ?? [];

    List<UserData> userTodos = List<UserData>.from(retrieveduserTodos);

    userTodos.add(userData);

    await userBox.put("userData", userTodos);
    await userBox.close();

    return true;
  }

  Future<List<UserData>> getTodos(String email) async {
    var userBox = await Hive.openBox(email);

    List<dynamic>? retrievedUserTodos =
        await userBox.get("userData", defaultValue: []);

    List<UserData> userTodos = List<UserData>.from(retrievedUserTodos!);

    await userBox.close();

    return userTodos;
  }

  Future<bool> deleteTodos(int index) async {
    try {
      String? userBoxName = await getUserBox();
      if (userBoxName == null) {
        return false;
      }

      var userBox = Hive.isBoxOpen(userBoxName)
          ? Hive.box<dynamic>(userBoxName)
          : await Hive.openBox(userBoxName);

      List<dynamic> retrievedUserTodos =
          await userBox.get("userData", defaultValue: []) ?? [];

      List<UserData> userTodos = List<UserData>.from(retrievedUserTodos);

      if (index >= 0 && index < userTodos.length) {
        userTodos.removeAt(index);
      } else {
        return false;
      }

      await userBox.put('userData', userTodos);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> editTodos(int index, UserData userData) async {
    String? userBoxName = await getUserBox();

    var userBox = await Hive.openBox(userBoxName!);

    List<dynamic> retrieveduserTodos =
        await userBox.get("userData", defaultValue: []) ?? [];

    List<UserData> userTodos = List<UserData>.from(retrieveduserTodos);

    if (index >= 0 && index < userTodos.length) {
      userTodos[index] = userData;
      await userBox.put('userData', userTodos);
    } else {
      await userBox.close();
      return false;
    }

    await userBox.close();
    return true;
  }

  Future<String?> getUserBox() async {
    var checkAuthBox = await Hive.openBox("checkAuthBox");
    String? userBoxName = checkAuthBox.get("email");
    await checkAuthBox.close();

    return userBoxName;
  }
}
