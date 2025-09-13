class Task {
  String? taskId;
  final String userId;
  String title;
  String description;
  String status;

  Task({
    this.taskId,
    required this.userId,
    required this.title,
    required this.description,
    this.status = 'Pending',
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'title': title,
      'description': description,
      'status': status,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      userId: map['user_id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      status: map['status'] as String,
    );
  }
}
