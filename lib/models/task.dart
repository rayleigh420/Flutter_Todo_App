class Task {
  int? id;
  String name;
  bool status;

  Task({
    this.id,
    required this.name,
    required this.status,
  });

  // Clone the current object with new properties
  Task clone({
    int? id,
    String? name,
    bool? status,
  }) =>
      Task(
        id: id ?? this.id,
        name: name ?? this.name,
        status: status ?? this.status,
      );

  Map<String, Object?> toJson() => {
        'ID': id,
        'NAME': name,
        'STATUS': status,
      };

  static Task fromJson(Map<String, Object?> json) => Task(
        id: json['ID'] as int,
        name: json['NAME'] as String,
        status: json['STATUS'] as bool,
      );
}
