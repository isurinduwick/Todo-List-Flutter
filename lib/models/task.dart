// lib/models/task.dart
class Task {
  //task class is defines a creating task object.each task represnt as single to do item
  String title; // field to store the name or title of task
  bool isCompleted; // indicates the task completed or not

  Task(
      {required this.title,
      this.isCompleted = false}); // constructor to initialize task
  // title is required  creating task
  factory Task.fromJson(Map<String, dynamic> json) {
    //factory Task.fromJson: A factory constructor to create a Task object from JSON data. Used when loading tasks from persistent storage.
    return Task(
      // creates a new task object with values extracted from JSON map
      title: json['title'], //get the title from jason data
      isCompleted: json['isCompleted'], //get status completion
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isCompleted': isCompleted,
    };
  } //toJson: Converts a Task object into a JSON map so it can be saved to persistent storage.
//title and isCompleted are saved as key-value pairs in the JSON map.
}
