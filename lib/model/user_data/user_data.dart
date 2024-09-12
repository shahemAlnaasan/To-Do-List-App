import 'package:hive_flutter/adapters.dart';

part 'user_data.g.dart';

@HiveType(typeId: 1)
class UserData {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  DateTime creatingDate;

  @HiveField(3)
  DateTime? deadline;

  @HiveField(4)
  String? image;

  UserData({
    required this.title,
    required this.description,
    required this.creatingDate,
    required this.deadline,
    required this.image,
  });
}
