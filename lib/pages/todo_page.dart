import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/bloc/todo_bloc.dart';
import 'package:todo_bloc/models/todo_model.dart';
import 'package:todo_bloc/pages/todo_list.dart';
import 'package:todo_bloc/pages/todo_screen.dart';

class TodoPage extends StatelessWidget {
  final TextEditingController todoController = TextEditingController();
  final String errorText = "Field cannot be empty!";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo'),
      ),
      body: BlocBuilder<TodoBloc, List<Todo>>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('Add todo'),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: todoController,
                    decoration: InputDecoration(
                      hintText: 'Listening to music',
                      errorText: errorText,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TodoList(),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'button1',
            onPressed: () {
              if (todoController.text != "")
                context.read<TodoBloc>().add(
                      TodoEvent.add(
                        Todo(todoController.text),
                      ),
                    );
              todoController.clear();
            },
            child: Icon(Icons.add),
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            heroTag: 'button2',
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => TodoScreen()));
            },
            child: Icon(Icons.next_plan_sharp),
          ),
        ],
      ),
    );
  }
}
