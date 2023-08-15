part of 'done_task_cubit.dart';

@immutable
sealed class DoneTaskState {}

final class DoneTaskInitial extends DoneTaskState {}
final class AddTaskdoneSuccess extends DoneTaskState {
  List<modeltasks> listTasks;
  AddTaskdoneSuccess({required this.listTasks});
}
final class AddTaskdoneFailuer extends DoneTaskState {}