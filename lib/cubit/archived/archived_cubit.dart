import 'package:bloc/bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';
import 'package:test1/models/model_tasks.dart';

part 'archived_state.dart';

class ArchivedCubit extends Cubit<ArchivedState> {
  ArchivedCubit() : super(ArchivedInitial());
    void addDone({required modeltasks model})async{
    try{
      var hive= await Hive.box<modeltasks>('archived');
      hive.add(model);
      
    }catch(e){
      emit(AddTaskarchivedFailuer());
    }
  }
  void getdonedata()async{
    try{
      var hive= await Hive.box<modeltasks>('archived');
      List<modeltasks> list=hive.values.toList();
      emit(AddTaskarchivedSuccess(listTasks: list));
    }catch(e){
      emit(AddTaskarchivedFailuer());
    }
  }
}
