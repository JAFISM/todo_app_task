import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_task/provider/todo_provider.dart';
import 'package:todo_app_task/views/todo_list_screen.dart';

import 'model/todo_model.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox('todos');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: MaterialApp(
        theme: ThemeData(
          // This is the theme of your application.
          primarySwatch:Colors.indigo,
          scaffoldBackgroundColor:Colors.white
        ),
        debugShowCheckedModeBanner: false,
        home:  const TodoListScreen(),
      ),
    );
  }
}
