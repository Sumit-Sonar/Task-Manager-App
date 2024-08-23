import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/taskmodel.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;


  void loadTasks() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? tasksStringList = pref.getStringList('tasks');
    if (tasksStringList != null) {
      _tasks = tasksStringList
          .map((taskString) => Task.fromJson(jsonDecode(taskString)))
          .toList();
      notifyListeners();
    }
  }

  void saveTasks() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> tasksStringList =
        _tasks.map((task) => jsonEncode(task.toJson())).toList();
    pref.setStringList('tasks', tasksStringList);
  }

  addTask(Task task) {
    _tasks.add(task);
    saveTasks();
    notifyListeners();
  }

  void updateTask(String id, Task newTask) {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index >= 0) {
      _tasks[index] = newTask;
      saveTasks();
      notifyListeners();
    }
  }

  deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    saveTasks();
    notifyListeners();
  }

  void isTaskComplete(String id) {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index >= 0) {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
      saveTasks();
      notifyListeners();
    }
  }

  void isTaskDone(String id, bool isDone) {
    final task = _tasks.firstWhere((task) => task.id == id);
    task.isDone = isDone;
    notifyListeners();
  }
}
