import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_task/views/todo_form_screen.dart';

import '../provider/todo_provider.dart';


class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TodoProvider>(context, listen: false).getTodosFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: Consumer<TodoProvider>(
        builder: (context, provider, child) {
          final todos = provider.todos;
          if (todos.isEmpty) {
            return const Center(
              child: Text('No todos yet.',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
            );
          }
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
            child: ListView.separated(
              separatorBuilder: (_,index)=>const SizedBox(height: 10,),
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  tileColor: Colors.indigo.withOpacity(0.3),
                  title:todo.completed?Text(todo.title,style: const TextStyle(decoration: TextDecoration.lineThrough),):Text(todo.title),
                  subtitle:todo.completed?Text(todo.description,style: const TextStyle(decoration: TextDecoration.lineThrough),):Text(todo.description),
                  leading: Checkbox(
                    value: todo.completed,
                    onChanged: (_) {
                      provider.toggleTodoCompletion(index);
                    },
                  ),
                  trailing: Wrap(
                    spacing: 18,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TodoFormScreen(
                                todo: todo,
                                index: index,
                              ),
                            ),
                          );
                        },
                        child: const Icon(Icons.edit,color: Colors.indigo,size: 25,),
                      ),
                      GestureDetector(
                        onTap: (){
                          provider.removeTodoFromList(index);
                        },
                        child: Container(
                          height: 25,
                            width: 25,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),color: Colors.red,),
                            child: const Icon(Icons.delete,color: Colors.white,size: 20,)),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TodoFormScreen(
                          todo: todo,
                          index: index,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width/2.5,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TodoFormScreen()),
            );
          },
          child: const Text("Add Task",style: TextStyle(fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}
