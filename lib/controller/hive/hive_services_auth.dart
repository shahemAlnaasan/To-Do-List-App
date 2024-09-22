import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../../model/user_info/user_info.dart';
import 'package:uuid/uuid.dart';

class HiveServices {
  Future<bool> storeUserInfo(UserInfo userInfo) async {
    String hashedEmail =
        userInfo.email.replaceAll(RegExp(r'[^\w\s]+'), '').toLowerCase();

    var userBox = await Hive.openBox(hashedEmail);

    if (userBox.containsKey("userInfo")) {
      await userBox.close();
      throw Exception('User already exists.');
    }

    String hashedPassword = hashPassword(userInfo.password);
    userInfo.password = hashedPassword;

    await userBox.put('userInfo', userInfo);

    await userBox.close();

    return true;
  }

  Future<UserInfo?> getUserInfo(String email, String password) async {
    String hashedEmail =
        email.replaceAll(RegExp(r'[^\w\s]+'), '').toLowerCase();
    var box = await Hive.openBox(hashedEmail);

    if (box.containsKey('userInfo')) {
      UserInfo userInfo = box.get('userInfo');

      if (checkPassword(password, userInfo.password) == true) {
        String accessToken = const Uuid().v4();

        userInfo.accessToken = accessToken;
        await box.put('userInfo', userInfo);

        storeUserToken(accessToken);
        storeUserEmail(email);

        await box.close();

        return userInfo;
      }
    }
    await box.close();
    return null;
  }

  Future<bool> changePassword(
      String email, String oldPassword, String newPassword) async {
    String hashedEmail =
        email.replaceAll(RegExp(r'[^\w\s]+'), '').toLowerCase();

    var box = await Hive.openBox(hashedEmail);

    if (!box.containsKey('userInfo')) {
      await box.close();
      throw Exception('Email does not exist.');
    }

    UserInfo? userInfo = box.get('userInfo');

    if (checkPassword(oldPassword, userInfo!.password)) {
      if (!checkPassword(newPassword, userInfo.password)) {
        String newHashedPassword = hashPassword(newPassword);

        userInfo.password = newHashedPassword;

        await box.put('userInfo', userInfo);

        await box.close();
        return true;
      } else {
        await box.close();
        throw Exception(
            'New password must be different from the old password.');
      }
    } else {
      await box.close();
      throw Exception('Old password is incorrect.');
    }
  }

  Future<bool> logOut(String email) async {
    try {
      String hashedEmail =
          email.replaceAll(RegExp(r'[^\w\s]+'), '').toLowerCase();

      var userBox = await Hive.openBox<UserInfo>(hashedEmail);

      UserInfo? userInfo = userBox.get('userInfo');

      var checkAuthBox = await Hive.openBox('checkAuthBox');

      await checkAuthBox.clear();

      if (userInfo != null) {
        userInfo.accessToken = '';
        await userBox.put('userInfo', userInfo);
      }

      await userBox.close();
      await checkAuthBox.close();

      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Error logging out: $e');
      }
      return false;
    }
  }

  Future<String?> checkStoredToken() async {
    try {
      var checkAuthBox = await Hive.openBox("checkAuthBox");
      final accessToken = checkAuthBox.get('accessToken');
      await checkAuthBox.close();

      if (accessToken is String) {
        return accessToken;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<String?> checkStoredEmail() async {
    try {
      var checkAuthBox = await Hive.openBox("checkAuthBox");
      final email = checkAuthBox.get('email');
      await checkAuthBox.close();

      if (email is String) {
        return email;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> storeUserToken(String accessToken) async {
    var checkAuthBox = await Hive.openBox("checkAuthBox");
    await checkAuthBox.put("accessToken", accessToken);
    await checkAuthBox.close();
  }

  Future<void> storeUserEmail(String email) async {
    var checkAuthBox = await Hive.openBox("checkAuthBox");
    await checkAuthBox.put("email", email);
    await checkAuthBox.close();
  }

  Future<UserInfo?> getUserInfoInit(String email) async {
    String hashedEmail =
        email.replaceAll(RegExp(r'[^\w\s]+'), '').toLowerCase();
    var userBox = await Hive.openBox<UserInfo>(hashedEmail);

    return userBox.get('userInfo');
  }

  String hashPassword(String password) {
    return BCrypt.hashpw(password, BCrypt.gensalt());
  }

  bool checkPassword(String password, String hashedPassword) {
    return BCrypt.checkpw(password, hashedPassword);
  }
}
