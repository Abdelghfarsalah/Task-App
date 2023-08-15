part of 'archived_cubit.dart';

@immutable
sealed class ArchivedState {}

final class ArchivedInitial extends ArchivedState {}
final class AddTaskarchivedSuccess extends ArchivedState {
  List<modeltasks> listTasks;
  AddTaskarchivedSuccess({required this.listTasks});
}
final class AddTaskarchivedFailuer extends ArchivedState {}