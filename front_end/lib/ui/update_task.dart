import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:task_manager_front/bloc/client_singleton.dart';
import 'package:task_manager_front/bloc/tasks_bloc.dart';
import 'package:task_manager_front/shortcuts/text_field.dart';
import 'package:task_manager_front/ui/view_tasks.dart';

class UpdateTask extends StatefulWidget {
  int id_task;
  UpdateTask({super.key, required this.id_task});

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  String task_field = "";
  String time_field = "";
  String date_field = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF9C29B2),
        title: Text(
          "Update Task",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          FormFieldWidget(
              text: "Task",
              icon: Icons.task_sharp,
              onChanged: (value) {
                task_field = value;
              },
              keyboardType: TextInputType.text,
              obscure: false),
          FormFieldWidget(
              text: "Date",
              icon: Icons.date_range,
              onChanged: (value) {
                date_field = value;
              },
              keyboardType: TextInputType.datetime,
              obscure: false),
          FormFieldWidget(
              text: "Time",
              icon: Icons.timer_outlined,
              onChanged: (value) {
                time_field = value;
              },
              keyboardType: TextInputType.datetime,
              obscure: false),
          Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02),
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.86,
              decoration: BoxDecoration(
                  color: Color(0xFF9C29B2),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: MaterialButton(
                onPressed: () async {
                  Uri update_uri = Uri.parse(
                      "http://10.0.2.2:8000/tasks/${widget.id_task}-update_task/");
                  Response update_response =
                      await HttpClientManager.client.put(update_uri, body: {
                    "date": date_field,
                    "time": time_field,
                    "task_to_do": task_field,
                  });
                  if (update_response.statusCode == 200) {
                    BlocProvider.of<TaskBloc>(context).add(refetch_task());
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => ViewTask()));
                  }
                },
                child: Text(
                  "Update",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              )),
        ],
      ),
    );
  }
}
