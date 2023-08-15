import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/Widgets/itemTasks.dart';
import 'package:test1/cubit/done/done_task_cubit.dart';
class DoneView extends StatelessWidget {
  const DoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoneTaskCubit,DoneTaskState>(
      builder: (context,state){
        if(state is AddTaskdoneSuccess){
          return state .listTasks.length!=0? Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ListView.builder(
              // reverse: true,
              itemCount: state.listTasks.length,
              itemBuilder: (context,index)
              {
                return itemtasks(model: state.listTasks[index],);
              }
              ),
          ):Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.menu_open,size: 250,color: Colors.grey,),
                Text('Please enter a task to view',style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900
                  ,color: Colors.grey
                ),)
              ],
            ),
          );
        }else{
          return Text('');
        }
      },
    );
  }
}