class Todo {
  Todo({
    required this.title,
    required this.dateTime,
    this.isDone = false,
  });

  Todo.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        dateTime = DateTime.parse(json['dateTime']),
        isDone = json['isDone'] ?? false;

  String title;
  DateTime dateTime;
  bool isDone;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'dateTime': dateTime.toIso8601String(),
      'isDone': isDone,
    };
  }
}