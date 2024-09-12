import 'package:hive_flutter/adapters.dart';

part 'user_info.g.dart';

@HiveType(typeId: 0)
class UserInfo {
  @HiveField(0)
  final String fullName;

  @HiveField(1)
  final String email;

  @HiveField(2)
  String password;

  @HiveField(3)
  final String confirmPassword;

  @HiveField(4)
  String accessToken;

  UserInfo(
      {required this.fullName,
      required this.email,
      required this.password,
      required this.confirmPassword,
      required this.accessToken});
}
