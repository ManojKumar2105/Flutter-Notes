import 'package:flutter/material.dart';
import 'package:notes/models/notes_model.dart';

class NoteView extends StatelessWidget {
  const NoteView(
      {super.key,
      required this.note,
      required this.index,
      required this.onNoteDeleted});

  final Note note;
  final int index;

  final Function(int) onNoteDeleted;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes View"),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                            "Do you really want to delete the note?"),
                        content: Text("Note ${note.title} will be deleted"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              onNoteDeleted(index);
                              Navigator.of(context).pop();
                            },
                            child: const Text("DELETE"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("CANCEL"),
                          )
                        ],
                      );
                    });
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText(
              note.title,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            SelectableText(
              note.body,
              style: const TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            note.image != null
                ? Image.file(
                    note.image!,
                    width: 300,
                    height: 180,
                    fit: BoxFit.cover,
                  )
                : const Text("")
          ],
        ),
      ),
    );
  }
}
