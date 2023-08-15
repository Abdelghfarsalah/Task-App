part of 'add_task_cubit.dart';

@immutable
sealed class AddTaskState {}

final class AddTaskInitial extends AddTaskState {}
final class AddTaskSuccess extends AddTaskState {
  List<modeltasks> listTasks;
  AddTaskSuccess({required this.listTasks});
}
final class AddTaskFailuer extends AddTaskState {}
