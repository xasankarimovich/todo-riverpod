class Todo {
  final int? id;
  final String title;
  final bool isCompleted;

  Todo({
    this.id,
    required this.title,
    this.isCompleted = false,
  });

  // Existing methods (toMap, fromMap)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      isCompleted: map['isCompleted'] == 1,
    );
  }

  // copyWith method
  Todo copyWith({
    int? id,
    String? title,
    bool? isCompleted,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
