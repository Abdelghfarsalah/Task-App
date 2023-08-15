import 'package:hive/hive.dart';
part 'model_tasks.g.dart';

@HiveType(typeId: 1)
class modeltasks extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String date;
  @HiveField(2)
  final String time;
  modeltasks({
    required this.date,
    required this.time,
    required this.title,
  });
}
