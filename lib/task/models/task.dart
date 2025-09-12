class Task {
  String? taskId;
  final String userId;
  String title;
  String description;
  bool isCompleted;

  Task({
    this.taskId,
    required this.userId,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'title': title,
      'description': description,
      'is_completed': isCompleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      userId: map['user_id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      isCompleted: map['is_completed'] as bool,
    );
  }
}
