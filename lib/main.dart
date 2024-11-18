// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/todo_list_screen.dart';

void main() {
  runApp(const MyApp()); //root of the application
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  //basic configuration for theame and home screen
  @override
  Widget build(BuildContext context) {
    // build - return the main structure of the app
    return MaterialApp(
      //config the apps theams and navigation
      debugShowCheckedModeBanner: false, //hide the debug banner
      title: 'To-Do List', //app name
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoListScreen(), //sets the initial screen of the app
    );
  }
}
