import 'package:cubit_with_sqflite/note_cubit/note_cubit.dart';
import 'package:cubit_with_sqflite/note_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNotePage extends StatefulWidget {
  final NoteModel? noteModel;
  AddNotePage({this.noteModel});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  var titleController = TextEditingController();

  var descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.noteModel != null) {
      // titleController.text = widget.noteModel!.title!;
      titleController.text = widget.noteModel!.title;
      descController.text = widget.noteModel!.desc;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
            ),
            const SizedBox(
              height: 11,
            ),
            TextField(
              controller: descController,
            ),
            const SizedBox(
              height: 21,
            ),
            ElevatedButton(
                child: Text('Add'),
                onPressed: () {
                  if (widget.noteModel == null) {
                    context.read<NoteCubit>().addNotes(NoteModel(
                          title: titleController.text.toString(),
                          desc: descController.text.toString(),
                        ));
                  } else {
                    context.read<NoteCubit>().updateNote(NoteModel(
                        title: titleController.text.toString(),
                        desc: descController.text.toString(),
                        note_id: widget.noteModel!.note_id));
                  }
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}
