import 'package:hive/hive.dart';

part 'todo_items_model.g.dart';

@HiveType(typeId: 0)
class TodoItmes {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String text;

  @HiveField(2)
  final String creatingDate;

  TodoItmes(
      {required this.title, required this.text, required this.creatingDate});
}
