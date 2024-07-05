// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class task {
  int id;
  int email;
  String task_to_do;
  String date;
  String time;
  task({
    required this.id,
    required this.email,
    required this.task_to_do,
    required this.date,
    required this.time,
  });

  task copyWith({
    int? id,
    int? email,
    String? task_to_do,
    String? date,
    String? time,
  }) {
    return task(
      id: id ?? this.id,
      email: email ?? this.email,
      task_to_do: task_to_do ?? this.task_to_do,
      date: date ?? this.date,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'task_to_do': task_to_do,
      'date': date,
      'time': time,
    };
  }

  factory task.fromMap(Map<String, dynamic> map) {
    return task(
      id: map['id'] as int,
      email: map['email'] as int,
      task_to_do: map['task_to_do'] as String,
      date: map['date'] as String,
      time: map['time'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory task.fromJson(String source) => task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'task(id: $id, email: $email, task_to_do: $task_to_do, date: $date, time: $time)';
  }

  @override
  bool operator ==(covariant task other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.email == email &&
      other.task_to_do == task_to_do &&
      other.date == date &&
      other.time == time;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      email.hashCode ^
      task_to_do.hashCode ^
      date.hashCode ^
      time.hashCode;
  }
}
