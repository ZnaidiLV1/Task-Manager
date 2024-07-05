// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:task_manager_front/bloc/client_singleton.dart';
import 'package:task_manager_front/bloc/tasks_bloc.dart';
import 'package:task_manager_front/serialiazers/Task.dart';
import 'package:task_manager_front/ui/update_task.dart';

class ViewTask extends StatefulWidget {
  ViewTask({super.key});

  @override
  State<ViewTask> createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF9C29B2),
        title: Text(
          "All Tasks",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<TaskBloc, task_state>(
        builder: (BuildContext context, state) {
          if (state is task_loaded) {
            return ListView.builder(
                itemCount: state.task_list.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Color(0xFF9C29B2),
                        borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                      leading: Icon(
                        Icons.task,
                        size: 40,
                        color: Colors.white,
                      ),
                      onLongPress: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => UpdateTask(
                                  id_task: state.task_list[index].id,
                                )));
                      },
                      title: Wrap(
                        children: [
                          Text(
                            state.task_list[index].task_to_do,
                            style: TextStyle(
                              fontSize: 30,
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        children: [
                          Row(children: [
                            Icon(
                              Icons.date_range_rounded,
                              size: 18,
                              color: Colors.white,
                            ),
                            Text(
                              " Date : ${state.task_list[index].date}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ]),
                          Row(children: [
                            Icon(
                              Icons.timer_sharp,
                              size: 18,
                              color: Colors.white,
                            ),
                            Text(
                              " Time : ${state.task_list[index].time}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ]),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () async {
                          Uri delete_uri = Uri.parse(
                              "http://10.0.2.2:8000/tasks/${state.task_list[index].id}-delete_task/");
                          Response delete_response =
                              await HttpClientManager.client.delete(delete_uri);
                          BlocProvider.of<TaskBloc>(context)
                              .add(refetch_task());
                        },
                      ),
                    ),
                  );
                });
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
