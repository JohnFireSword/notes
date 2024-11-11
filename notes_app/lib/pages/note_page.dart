import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:notes_app/components/drawer.dart';
import 'package:notes_app/components/login_or_register.dart';

import 'package:notes_app/models/note.dart';
import 'package:notes_app/models/note_database.dart';
import 'package:notes_app/pages/auth_screen.dart';
import 'package:notes_app/pages/notes_details.dart';
import 'package:notes_app/pages/settings_page.dart';
import 'package:notes_app/pages/task_details.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final textController = TextEditingController();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    readNotes();
  }

  void logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginOrRegister()),
      (route) => false,
    );
    
  }

  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  void updateNote(Note note) {
    textController.text = note.text;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Update note"),
        backgroundColor: Theme.of(context).colorScheme.surface,
        content: TextField(
          controller: textController,
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              context.read<NoteDatabase>().updateNote(
                    note.id,
                    textController.text,
                  );
              textController.clear();
              Navigator.pop(context);
            },
            child: const Text("Update"),
          )
        ],
      ),
    );
  }

  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  void _navigateToScreen(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const NotesDetails(),
      const TaskDetails(),
      const SettingsPage()
    ];

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        height: 60,
        color: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).colorScheme.surface,
        animationDuration: const Duration(milliseconds: 300),
        onTap: _navigateToScreen,
        items: [
          Icon(
            Icons.home,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          Icon(
            Icons.task_alt_sharp,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          Icon(
            Icons.settings,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ],
      ),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child:
                IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
          )
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: const MyDrawer(),
      body: pages[_selectedIndex],
    );
  }
}
