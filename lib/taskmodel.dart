class Task {
  String id;
  String title;
  String description;
  bool isCompleted;
  bool isDone;

  Task({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.isDone = false
  });
// Convert a Task into a Map (for JSON serialization)

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'isDone': isDone
    };
  }

  // Convert a Map (from JSON) into a Task

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'],
      isDone: json['isDone']
    );
  }
}
