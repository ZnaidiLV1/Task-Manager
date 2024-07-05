import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_front/auth/login.dart';
import 'package:task_manager_front/bloc/email_bloc.dart';
import 'package:task_manager_front/bloc/tasks_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider<EmailBloc>(create: (context) => EmailBloc(),),
        BlocProvider<TaskBloc>(create: (context)=>TaskBloc(context),)
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const LoginPage(),
        ),
    )
    ;
  }
}
