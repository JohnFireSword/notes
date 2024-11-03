import 'package:notes_app/models/todo.dart';

abstract class TodoRepo {
  Future<List<Todo>> getTodos();

  Future<void> updateTodos(Todo todo);

  Future<void> addTodo(String text);

  Future<void> deleteTodo(Todo todo);
}
