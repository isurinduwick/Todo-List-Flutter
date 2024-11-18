// lib/utils/shared_preferences_helper.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/task.dart';

class SharedPreferencesHelper {
  static Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksData = prefs.getString('tasks');
    if (tasksData != null) {
      final List decodedData = jsonDecode(tasksData);
      return decodedData.map((item) => Task.fromJson(item)).toList();
    }
    return [];
  }

  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData =
        jsonEncode(tasks.map((task) => task.toJson()).toList());
    await prefs.setString('tasks', encodedData);
  }
}
