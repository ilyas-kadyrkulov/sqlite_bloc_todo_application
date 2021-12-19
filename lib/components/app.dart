import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_bloc_todo_application/configs/const_text.dart';
import 'package:sqlite_bloc_todo_application/repositories/todo_bloc.dart';

import 'todo_list/todo_list_view.dart';

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ConstText.todoListView,
      debugShowCheckedModeBanner: false,
      home: Provider<TodoBloc>(
        create: (context) => new TodoBloc(),
        dispose: (context, bloc) => bloc.dispose(),
        child: TodoListView()
      ),
    );
  }
}