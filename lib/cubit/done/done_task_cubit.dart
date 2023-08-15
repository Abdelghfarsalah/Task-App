import 'package:bloc/bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';
import 'package:test1/models/model_tasks.dart';

part 'done_task_state.dart';

class DoneTaskCubit extends Cubit<DoneTaskState> {
  DoneTaskCubit() : super(DoneTaskInitial());
  void addDone({required modeltasks model})async{
    try{
      var hive= await Hive.box<modeltasks>('done');
      hive.add(model);
      
    }catch(e){
      emit(AddTaskdoneFailuer());
    }
  }
  void getdonedata()async{
    try{
      var hive= await Hive.box<modeltasks>('done');
      List<modeltasks> list=hive.values.toList();
      emit(AddTaskdoneSuccess(listTasks: list));
    }catch(e){
      emit(AddTaskdoneFailuer());
    }
  }
}
