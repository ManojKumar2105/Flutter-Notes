import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes/models/notes_model.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({super.key, required this.onNoteCreated});

  final Function(Note) onNoteCreated;
  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  File? _selectedImage;
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: "Title"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: bodyController,
              style: const TextStyle(fontSize: 20),
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: "Description"),
            ),
            SizedBox(
              height: 10,
            ),
            _selectedImage != null
                ? Image.file(
                    _selectedImage!,
                    width: 300,
                    height: 180,
                    fit: BoxFit.cover,
                  )
                : const Text("")
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     if (titleController.text.isEmpty) {
      //       return;
      //     }

      //     if (bodyController.text.isEmpty) {
      //       return;
      //     }

      //     final note =
      //         Note(title: titleController.text, body: bodyController.text);

      //     widget.onNoteCreated(note);
      //     Navigator.of(context).pop();
      //   },
      //   child: const Icon(Icons.save),
      // ),
      floatingActionButton: Wrap(
        direction: Axis.horizontal,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: FloatingActionButton(
              heroTag: "btn3",
              onPressed: () {
                if (titleController.text.isEmpty) {
                  return;
                }

                if (bodyController.text.isEmpty) {
                  return;
                }

                final note = Note(
                    title: titleController.text,
                    body: bodyController.text,
                    image: _selectedImage);

                widget.onNoteCreated(note);
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.save),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: FloatingActionButton(
              heroTag: "btn4",
              onPressed: () => {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title:
                            const Text("Choose image from Gallery or Camera?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              _pickImageFromGallery(ImageSource.gallery);
                              Navigator.of(context).pop();
                            },
                            child: const Text("From Gallery"),
                          ),
                          TextButton(
                            onPressed: () {
                              _pickImageFromGallery(ImageSource.camera);
                              Navigator.of(context).pop();
                            },
                            child: const Text("From Camera"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("CANCEL"),
                          )
                        ],
                      );
                    })
              },
              child: const Icon(Icons.image),
            ),
          )
        ],
      ),
    );
  }

  Future _pickImageFromGallery(ImageSource source) async {
    final returnedImage = await ImagePicker().pickImage(source: source);
    if (returnedImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(returnedImage!.path);
    });
  }

  // Future _pickImageFromCamera() async {
  //   final returnedImage =
  //       await ImagePicker().pickImage(source: ImageSource.camera);
  //   if (returnedImage == null) {
  //     return;
  //   }
  //   setState(() {
  //     _selectedImage = File(returnedImage!.path);
  //   });
  // }
}
