import 'package:isar/isar.dart';
import 'package:notes_app/models/todo.dart';

part 'todo_database.g.dart';

@Collection()
class TodoDatabase {
  Id id = Isar.autoIncrement;
  late String text;
  late bool isCompleted;

  Todo toDomain() {
    return Todo(id: id, text: text, isCompleted: isCompleted);
  }

  static TodoDatabase fromDomain(Todo todo) {
    return TodoDatabase()
      ..id = todo.id
      ..text = todo.text
      ..isCompleted = todo.isCompleted;
  }

 
}
