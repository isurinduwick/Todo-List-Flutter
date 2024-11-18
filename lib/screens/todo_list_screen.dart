// lib/screens/todo_list_screen.dart
import 'package:flutter/material.dart';
import '../models/task.dart';
import '../utils/shared_preferences_helper.dart';

// ststefull widget manages the to do list cahnges are task are added ,completed or deleted
class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override //createState: Links the state object _TodoListScreenState to this widget, enabling dynamic changes.

  State<TodoListScreen> createState() => _TodoListScreenState();
}

//Attributes and Initialization
class _TodoListScreenState extends State<TodoListScreen> {
  final List<Task> _tasks = []; // list to store the all task

  @override
  void initState() {
    super
        .initState(); //initState: Called when the widget is first created. It loads tasks from persistent storage.
  }

//loading and saving task
  Future<void> _loadTasks() async {
    final tasks = await SharedPreferencesHelper.loadTasks();
    setState(() {
      //setstate to refresh the ui
      _tasks.addAll(tasks);
    });
  }

  Future<void> _saveTasks() async {
    await SharedPreferencesHelper.saveTasks(_tasks);
  }

//managing task
  void _addTask(String title) {
    //-addTask adds anew task to _task ansd save it
    setState(() {
      _tasks.add(Task(title: title, isCompleted: false));
    });
    _saveTasks();
  }

  void _toggleTaskCompletion(int index) {
    //_toggleTaskCompletion: Marks a task as completed or uncompleted by toggling isCompleted.
    setState(() {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
    });
    _saveTasks();
  }

//delete task
  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
    _saveTasks();
  }

  void _showAddTaskDialog() {
    final TextEditingController taskController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Task'),
          content: TextField(
            controller: taskController,
            decoration: const InputDecoration(hintText: 'Enter task title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final String taskTitle = taskController.text.trim();
                if (taskTitle.isNotEmpty) {
                  _addTask(taskTitle);
                }
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

//ui construction
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddTaskDialog,
          ),
        ],
      ),
      body: _tasks.isEmpty
          ? const Center(child: Text('No tasks yet. Add some!'))
          : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return ListTile(
                  leading: Checkbox(
                    value: task.isCompleted,
                    onChanged: (bool? value) {
                      _toggleTaskCompletion(index);
                    },
                  ),
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration:
                          task.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _deleteTask(index);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog, // Opens the dialog to add new tasks.
        child: const Icon(Icons.add), // Add icon for the button.
        backgroundColor:
            Color.fromARGB(255, 128, 5, 228), // Set the color to pink.
      ),
    );
  }
}
