import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:task_manager_front/bloc/client_singleton.dart';
import 'package:task_manager_front/bloc/email_bloc.dart';
import 'package:task_manager_front/serialiazers/Task.dart';

// Define events
abstract class task_event extends Equatable {
  const task_event();
  @override
  List<Object> get props => [];
}

class fetch_task extends task_event {}

class refetch_task extends task_event {}

// Define states
abstract class task_state extends Equatable {
  const task_state();
  @override
  List<Object> get props => [];
}

class task_initialstate extends task_state {}

class task_loading extends task_state {}

class task_loaded extends task_state {
  final List<task> task_list;
  task_loaded(this.task_list);

  @override
  List<Object> get props => [task_list];
}

// Define the BLoC
class TaskBloc extends Bloc<task_event, task_state> {
  final BuildContext context;

  TaskBloc(this.context) : super(task_initialstate()) {
    on<fetch_task>(_fetchTasks);
    on<refetch_task>(_refetchTasks);
  }

  Future<void> _fetchTasks(fetch_task event, Emitter<task_state> emit) async {
    emit(task_loading());

    final emailBloc = BlocProvider.of<EmailBloc>(context);
    final emailState = emailBloc.state;

    if (emailState is emailLoaded) {
      final String email = emailState.email;
      Uri tasksUri = Uri.parse("http://10.0.2.2:8000/tasks/$email-get_tasks/");
      Response tasksResponse = await HttpClientManager.client.get(tasksUri);

      if (tasksResponse.statusCode == 200) {
        final List<dynamic> responseData = json.decode(tasksResponse.body);
        final List<task> allTasks =
            responseData.map((taskData) => task.fromMap(taskData)).toList();
        emit(task_loaded(allTasks));
      } else {
        emit(task_initialstate()); 
      }
    }
  }

  void _refetchTasks(refetch_task event, Emitter<task_state> emit) {
    add(fetch_task());
  }
}
