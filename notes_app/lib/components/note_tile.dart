import 'package:flutter/material.dart';
import 'package:notes_app/components/note_settings.dart';
import 'package:popover/popover.dart';

class NoteTile extends StatelessWidget {
  final String text;
  final void Function()? onEditPressed;
  final void Function()? onDeletePressed;
  const NoteTile(
      {super.key,
      required this.text,
      required this.onDeletePressed,
      required this.onEditPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8)
        
        ),
        child: ListTile(
          title: Text(text),
          trailing: Builder(
              builder: (context) => IconButton(
                  onPressed: () => showPopover(
                      context: context,
                      width: 100,
                      height: 100,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      bodyBuilder: (context) => NoteSettings(
                            onEditTap: onEditPressed,
                            onDeleteTap: onDeletePressed,
                          )),
                  icon: const Icon(Icons.more_vert_outlined))),
        ));
  }
}
