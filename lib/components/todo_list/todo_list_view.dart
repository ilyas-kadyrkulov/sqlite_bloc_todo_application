import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_bloc_todo_application/components/todo_edit/todo_edit_view.dart';
import 'package:sqlite_bloc_todo_application/configs/const_text.dart';
import 'package:sqlite_bloc_todo_application/models/todo.dart';
import 'package:sqlite_bloc_todo_application/repositories/todo_bloc.dart';

class TodoListView extends StatelessWidget {

  @override 
  Widget build(BuildContext context) {
    final _bloc = Provider.of<TodoBloc>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text(ConstText.todoListView)),
      body: StreamBuilder<List<Todo>>(
        stream: _bloc.todoStream,
        builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                
                Todo todo = snapshot.data[index];

                return Dismissible(
                  key: Key(todo.id),
                  background: Container(
                      alignment: Alignment.centerLeft,
                      color: Colors.green,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Icon(Icons.done, color: Colors.white),
                      )
                  ),
                  secondaryBackground: Container(
                      alignment: Alignment.centerRight,
                      color: Colors.red,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: Icon(Icons.delete, color: Colors.white),
                      )
                  ),
                  onDismissed: (direction) {
                    _bloc.delete(todo.id);
                  },
                  child: Card(
                    child: ListTile(
                      onTap: (){ 
                        _moveToEditView(context, _bloc, todo);
                      },
                      title: Text("${todo.title}"),
                      subtitle: Text("${todo.note}"),
                      trailing: Text("${todo.dueDate.toLocal().toString()}"),
                      isThreeLine: true,
                    )
                  ),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){ _moveToCreateView(context, _bloc); },
        child: Icon(Icons.add, size: 40),
      ),
    );
  }

  _moveToEditView(BuildContext context, TodoBloc bloc, Todo todo) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => TodoEditView(todoBloc: bloc, todo: todo))
  );

  _moveToCreateView(BuildContext context, TodoBloc bloc) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => TodoEditView(todoBloc: bloc, todo: Todo.newTodo()))
  );
}
