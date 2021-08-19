class Todo {
  int? id;
  String? title;
  int? userId;
  bool? completed;

  Todo({
    this.id,
    this.title,
    this.userId,
    this.completed,
  });

  factory Todo.fromMap(Map<String, dynamic> json) => new Todo(
    id: json["id"],
    title: json["title"],
    userId: json["userId"],
    completed: json["completed"],
  );

  static List<Todo> listFromMap(final List<dynamic> jsons) {
    return jsons.map<Todo>((final dynamic json) {
      return Todo.fromMap(json);
    }).toList();
  }
}
