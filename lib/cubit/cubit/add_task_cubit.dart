import 'package:bloc/bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';
import 'package:test1/models/model_tasks.dart';

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit() : super(AddTaskInitial());

  void addtasks({required String title,required String time,required String date})async{
    try{
      var hive= await Hive.box<modeltasks>('todo');
      hive.add(modeltasks(date: date, time: time, title: title));
      
    }catch(e){
      emit(AddTaskFailuer());
    }
  }
  void getdata()async{
    try{
      var hive= await Hive.box<modeltasks>('todo');
      List<modeltasks> list=hive.values.toList();
      emit(AddTaskSuccess(listTasks: list));
    }catch(e){
      emit(AddTaskFailuer());
    }
  }  
  
}
