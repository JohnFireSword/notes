import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/models/todo.dart';
import 'package:notes_app/models/todo_database.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar =
        await Isar.open([NoteSchema, TodoDatabaseSchema], directory: dir.path);
  }

  final List<Note> currentNotes = [];
//NOTES
  Future<void> addNote(String textFromUser) async {
    final newNote = Note()..text = textFromUser;
    await isar.writeTxn(() => isar.notes.put(newNote));
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    List<Note> fetchedNotes = await isar.notes.where().findAll();

    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
    notifyListeners();
  }

  void togglePin(Note note) async {
    note.isPinned = !note.isPinned;

    currentNotes.sort((a, b) {
      if (a.isPinned && !b.isPinned) return -1; 
      if (!a.isPinned && b.isPinned) return 1; 
      return a.id.compareTo(
          b.id); 
    });
    notifyListeners();
  }

  Future<void> updateNote(
    int id,
    String newText,
  ) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.text = newText;

      await isar.writeTxn(() => isar.notes.put(existingNote));
      await fetchNotes();
    }
  }

  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));

    await fetchNotes();
  }

  //TASKS

  Future<List<Todo>> getTodos() async {
    final todos = await isar.todoDatabases.where().findAll();

    return todos.map((todo) => todo.toDomain()).toList();
  }

  Future<void> addTodo(String text) async {
    final newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch,
      text: text,
    );

    final todoIsar = TodoDatabase.fromDomain(newTodo);

    await isar.writeTxn(() async {
      await isar.todoDatabases.put(todoIsar);
      getTodos();
      notifyListeners();
    });
  }

  Future<void> updateTodos(Todo todo) async {
    final todoIsar = TodoDatabase.fromDomain(todo);
    await isar.writeTxn(() async {
      await isar.todoDatabases.put(todoIsar);

      notifyListeners();
    });
  }

  Future<void> deleteTodo(Todo todo) async {
    await isar.writeTxn(() async {
      await isar.todoDatabases.delete(todo.id);

      notifyListeners();
    });
  }
}
