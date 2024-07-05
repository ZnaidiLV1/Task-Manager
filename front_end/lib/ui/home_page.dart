import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:task_manager_front/bloc/email_bloc.dart';
import 'package:task_manager_front/bloc/tasks_bloc.dart';
import 'package:task_manager_front/ui/add_task.dart';
import 'package:task_manager_front/ui/view_tasks.dart';

class HomePage extends StatefulWidget {
  String refresh_token;
  HomePage({super.key, required this.refresh_token});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<EmailBloc>(context).add(fetchEmail(widget.refresh_token));
    BlocProvider.of<TaskBloc>(context).add(fetch_task());
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> token_info = Jwt.parseJwt(widget.refresh_token);

    // String username = token_info["email"];
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02),
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.86,
              decoration: BoxDecoration(
                  color: Color(0xFF9C29B2),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ViewTask()));
                },
                child: Text(
                  "View Tasks",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02),
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.86,
              decoration: BoxDecoration(
                  color: Color(0xFF9C29B2),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => AddTask()));
                },
                child: Text(
                  "Add a Task",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
