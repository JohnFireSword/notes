import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/components/drawer_content.dart';
import 'package:notes_app/pages/settings_drawer.dart';
import 'package:notes_app/pages/settings_page.dart';
import 'package:notes_app/pages/task_details.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 50, bottom: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Text(
              'Dashboard',
              style: GoogleFonts.dmSerifText(fontSize: 35),
            ),
          ),
          DrawerContents(
            title: 'Notes',
            leading: const Icon(Icons.home_outlined),
            onTap: () => Navigator.pop(context),
          ),
          DrawerContents(
            title: 'Tasks',
            leading: const Icon(Icons.task_alt_outlined),
            onTap: () => Navigator.pop(context)
            
          ),
          DrawerContents(
            title: 'Settings',
            leading: const Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsDrawerPage()),
              );
            },
          ),
          Divider(
            color: Theme.of(context).colorScheme.secondary,
          ),
          DrawerContents(
            title: 'Support',
            leading: const Icon(Icons.support_agent_outlined),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          DrawerContents(
            title: 'What' 's new',
            leading: const Icon(Icons.new_releases_outlined),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          DrawerContents(
            title: 'Privacy Policy',
            leading: const Icon(Icons.privacy_tip_outlined),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
