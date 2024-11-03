import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/models/note_database.dart';
import 'package:notes_app/models/todo.dart';
import 'package:provider/provider.dart';

class TaskDetails extends StatefulWidget {
  const TaskDetails({super.key});

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  final TextEditingController textController = TextEditingController();
  List<Todo> todos = [];

  @override
  void initState() {
    super.initState();
    readTasks();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void readTasks() async {
    final fetchedTodos = await context.read<NoteDatabase>().getTodos();
    setState(() {
      todos = fetchedTodos;
    });
  }

  void createTask() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          contentPadding: const EdgeInsets.all(20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.task_alt,
                color: Theme.of(context).colorScheme.secondary,
                size: 50,
              ),
              const SizedBox(height: 20),
              Text(
                "Create New Task",
                style: GoogleFonts.dmSerifText(
                  fontSize: 22,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 1.5,
                    ),
                  ),
                  hintText: "Enter task description",
                  hintStyle: GoogleFonts.openSans(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.5),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                ),
                controller: textController,
              ),
            ],
          ),
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
              ),
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                if (textController.text.isNotEmpty) {
                  await context
                      .read<NoteDatabase>()
                      .addTodo(textController.text);
                  textController.clear();
                  Navigator.pop(context);
                  readTasks();
                }
              },
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
              child: Text(
                "Create",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void deleteTodo(Todo todo) async {
    await context.read<NoteDatabase>().deleteTodo(todo);
    readTasks();
  }

  void toggleCompletion(Todo todo) async {
    final updatedTodo = todo.toggleCompletion();
    setState(() {
      final index = todos.indexOf(todo);
      todos[index] = updatedTodo;
    });
    await context.read<NoteDatabase>().updateTodos(updatedTodo);
  }

  void reorderTasks(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex--;
      final Todo todo = todos.removeAt(oldIndex);
      todos.insert(newIndex, todo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Tasks',
                  style: GoogleFonts.dmSerifText(
                    fontSize: 48,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    onPressed: createTask,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: todos.isEmpty
                ? const Center(child: Text('No tasks available'))
                : Container(
                    padding: const EdgeInsets.all(15),
                    child: ReorderableListView(
                      onReorder: reorderTasks,
                      children: [
                        for (final todo in todos)
                          ListTile(
                            minVerticalPadding: 25,
                            key: ValueKey(todo.id),
                            tileColor: todo.isCompleted
                                ? Theme.of(context).colorScheme.primary
                                : Colors.transparent,
                            title: Text(
                              todo.text,
                              style: TextStyle(
                                fontSize: 18,
                                decoration: todo.isCompleted
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                color: todo.isCompleted
                                    ? Colors.grey
                                    : Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.color,
                              ),
                            ),
                            leading: Checkbox(
                              activeColor:
                                  Theme.of(context).colorScheme.secondary,
                              checkColor: Theme.of(context).colorScheme.primary,
                              value: todo.isCompleted,
                              onChanged: (bool? value) {
                                toggleCompletion(todo);
                              },
                            ),
                            trailing: IconButton(
                              onPressed: () => showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    backgroundColor:
                                        Theme.of(context).colorScheme.surface,
                                    contentPadding: const EdgeInsets.all(20),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.warning_amber_rounded,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          size: 50,
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          "Are you sure?",
                                          style: GoogleFonts.dmSerifText(
                                            fontSize: 22,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "Do you really want to delete this task? This action cannot be undone.",
                                          style: GoogleFonts.openSans(
                                            fontSize: 16,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                                .withOpacity(0.7),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    actionsPadding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: TextButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .surfaceVariant,
                                        ),
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .inversePrimary,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          deleteTodo(todo);
                                          readTasks();
                                        },
                                        style: TextButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .error,
                                        ),
                                        child: Text(
                                          "Yes, Delete",
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onError,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              icon: Icon(
                                Icons.cancel,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
