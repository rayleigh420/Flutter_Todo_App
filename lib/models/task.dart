class Task {
  int? id;
  String name;
  DateTime? dueTime;
  bool status;

  Task({
    this.id,
    required this.name,
    this.dueTime,
    required this.status,
  });

  // Clone the current object with new properties
  Task clone({
    int? id,
    String? name,
    DateTime? dueTime,
    bool? status,
  }) =>
      Task(
        id: id ?? this.id,
        name: name ?? this.name,
        dueTime: dueTime ?? this.dueTime,
        status: status ?? this.status,
      );

  Map<String, Object?> toJson() => {
        'ID': id,
        'NAME': name,
        'DUETIME': dueTime?.toIso8601String(),
        'STATUS': status,
      };

  static Task fromJson(Map<String, Object?> json) => Task(
        id: json['ID'] as int,
        name: json['NAME'] as String,
        dueTime: json['DUETIME'] != null
            ? DateTime.parse(json['DUETIME'] as String)
            : null,
        status: json['STATUS'] as bool,
      );
}
