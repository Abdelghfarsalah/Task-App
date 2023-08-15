import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:test1/cubit/cubit/add_task_cubit.dart';
import 'package:test1/cubit/archived/archived_cubit.dart';
import 'package:test1/cubit/done/done_task_cubit.dart';
import 'package:test1/models/model_tasks.dart';

class itemtasks extends StatelessWidget {
  const itemtasks({super.key,required this.model});
  final modeltasks model;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('1'),
      onDismissed: (direction) {
        model.delete();
      },
      child: AspectRatio(
        aspectRatio: 1 / 0.4,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child:  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.blue,
                        child: Text(
                          '${model.time}',
                          style:const TextStyle(
                            color: Colors.white,
                            fontSize: 20, fontWeight: FontWeight.w900),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${model.title}',
                            style:
                                TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
                          ),
                          Text(
                            '${model.date}',
                            style:
                                TextStyle(fontSize: 15),
                          ),
                        ],
                      )
                    ,Spacer()
                    ,IconButton(onPressed: 
                    (){
                      model.delete();
                      BlocProvider.of<AddTaskCubit>(context).getdata();
                      BlocProvider.of<DoneTaskCubit>(context).addDone(model: model);
                      BlocProvider.of<DoneTaskCubit>(context).getdonedata();
                      BlocProvider.of<ArchivedCubit>(context).getdonedata();
                    }, 
                    icon:Icon(Icons.cloud_done_sharp,size: 34,color: Colors.green,) )
                    ,SizedBox(
                      width: 20,
                    )
                    ,IconButton(onPressed: 
                    (){
                      model.delete();
                      BlocProvider.of<ArchivedCubit>(context).addDone(model: model);
                      BlocProvider.of<AddTaskCubit>(context).getdata();
                      BlocProvider.of<DoneTaskCubit>(context).getdonedata();
                      BlocProvider.of<ArchivedCubit>(context).getdonedata();
                    }, 
                    icon:Icon(Icons.archive_outlined,size: 34,) )
                    ]),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Divider(
                thickness: 1,
                height: 0,
                endIndent: 0,
                indent: 0,
              ),
            )
            ],
          ),
        ),
      ),
    );
  }
}
