

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:test1/Widgets/textFiled.dart';
import 'package:test1/cubit/cubit/add_task_cubit.dart';
import 'package:test1/cubit/archived/archived_cubit.dart';
import 'package:test1/cubit/done/done_task_cubit.dart';
import 'package:test1/models/model_tasks.dart';
import 'package:test1/screens/DoneView.dart';
import 'package:test1/screens/archivedView.dart';
import 'package:test1/screens/tasks.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<modeltasks>('todo');
  await Hive.openBox<modeltasks>('done');
  await Hive.openBox<modeltasks>('archived');

  runApp(
    MultiBlocProvider(providers: [
      BlocProvider(create: (context) => AddTaskCubit()),
      BlocProvider(create: (context) => DoneTaskCubit()),
      BlocProvider(create: (context)=>ArchivedCubit())
    ], child: MaterialApp(debugShowCheckedModeBanner: false, home: MyWidget())),
  );
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  
  int currentIndex = 0;
  var timeConterolar = TextEditingController();
  var titleConterolar = TextEditingController();
  var DateConterolar = TextEditingController();
  var formkey = GlobalKey<FormState>();
  List<Widget> listScreen = const [tasksView(), DoneView(), archivedView()];
  List<String> listAppbar = ['Tasks', 'done', 'archived'];
  bool show = false;
  Icon floatingactionIcon = Icon(Icons.edit);
  @override
  void initState() {
    super.initState();
  }

  var key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AddTaskCubit>(context).getdata();
    BlocProvider.of<DoneTaskCubit>(context).getdonedata();
    return Scaffold(
      key: key,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(listAppbar[currentIndex]),
      ),
      body: listScreen[currentIndex],
      floatingActionButton:FloatingActionButton(
        onPressed: () {
          if (show) {
            if (formkey.currentState!.validate()) {
              Navigator.pop(context);
              BlocProvider.of<AddTaskCubit>(context).addtasks(
                  title: titleConterolar.text,
                  time: timeConterolar.text,
                  date: DateConterolar.text);
              BlocProvider.of<AddTaskCubit>(context).getdata();
              show = false;
              setState(() {
                floatingactionIcon = Icon(Icons.edit);
                
              });
              titleConterolar.clear();
              timeConterolar.clear();
              DateConterolar.clear();
            }
          } else {
            show = true;
            setState(() {
              floatingactionIcon = Icon(Icons.add);
            });
            key.currentState?.showBottomSheet(elevation: 0, enableDrag: false,
                (context) {
              return Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(16)),
                height: 320,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        textFoemfiled(
                          valitator: (String? data) {
                            if (data!.isEmpty) return 'title is requird';
                          },
                          texttype: TextInputType.name,
                          controller: titleConterolar,
                          onchanged: (data) {
                            titleConterolar.text = data;
                          },
                          hint: 'enter tilte',
                          label: 'Title',
                          prefixIcon: Icon(Icons.title),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        textFoemfiled(
                          valitator: (data) {
                            if (data!.isEmpty) return 'Task Time is requird';
                          },
                          texttype: TextInputType.name,
                          controller: timeConterolar,
                          hint: 'enter Task Time',
                          label: 'Task Time',
                          onTap: () {
                            showTimePicker(
                                    confirmText: 'done',
                                    context: context,
                                    initialTime: TimeOfDay.now())
                                .then((value) {
                              timeConterolar.text = value!.format(context);
                            });
                          },
                          prefixIcon: Icon(Icons.watch_later_outlined),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        textFoemfiled(
                          valitator: (data) {
                            if (data!.isEmpty) return 'Data Time is requird';
                          },
                          texttype: TextInputType.datetime,
                          controller: DateConterolar,
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse('2025-05-03'))
                                .then((value) {
                              DateConterolar.text =
                                  DateFormat.yMMMEd().format(value!);
                            });
                          },
                          hint: 'enter Date Task',
                          label: 'Date Task',
                          prefixIcon: Icon(Icons.date_range),
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
          }
        },
        child: floatingactionIcon,
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'text'),
            BottomNavigationBarItem(
                icon: Icon(Icons.check_circle_outline_rounded), label: 'text'),
            BottomNavigationBarItem(
                icon: Icon(Icons.archive_outlined), label: 'text'),
          ]),
    );
  }
}
