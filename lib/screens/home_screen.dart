import 'package:flutter/material.dart';
import 'package:notes/models/notes_model.dart';
import 'package:notes/screens/checklist.dart';
import 'package:notes/screens/create_note.dart';
import 'package:notes/screens/widgets/note_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> notes = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Notes"),
        ),
        body: ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return NoteCard(
                note: notes[index],
                index: index,
                onNoteDeleted: onNoteDeleted,
              );
            }),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () => {
        //     Navigator.of(context).push(MaterialPageRoute(
        //         builder: (context) => CreateNote(onNoteCreated: onNoteCreated)))
        //   },
        //   child: const Icon(Icons.add),
        // ),
        floatingActionButton: Wrap(
          direction: Axis.horizontal,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: FloatingActionButton(
                heroTag: "btn1",
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => ListAdd()));
                },
                child: Icon(Icons.checklist),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: FloatingActionButton(
                heroTag: "btn2",
                onPressed: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          CreateNote(onNoteCreated: onNoteCreated)))
                },
                child: const Icon(Icons.add),
              ),
            )
          ],
        ));
  }

  void onNoteCreated(Note note) {
    notes.add(note);
    setState(() {});
  }

  void onNoteDeleted(int index) {
    notes.removeAt(index);
    setState(() {});
  }
}
