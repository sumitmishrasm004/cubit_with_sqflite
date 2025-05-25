import 'package:cubit_with_sqflite/add_note_page.dart';
import 'package:cubit_with_sqflite/note_cubit/note_cubit.dart';
import 'package:cubit_with_sqflite/note_cubit/note_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    context.read<NoteCubit>().getAllNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('All Notes'),
        ),
        body: BlocBuilder<NoteCubit, NoteState>(builder: (_, state) {
          if (state is NoteLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NoteErrorState) {
            return Center(
              child: Text(state.errorMsg),
            );
          } else if (state is NoteLoadedState) {
            return ListView.builder(
                itemCount: state.arrNotes.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    leading: Text("${index + 1}"),
                    title: Text(state.arrNotes[index].title),
                    subtitle: Text(state.arrNotes[index].desc),
                    trailing: IconButton(icon: const Icon(Icons.remove), onPressed: (){
                      context.read<NoteCubit>().deleteNote(state.arrNotes[index].note_id!);
                    },),
                    onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context) => AddNotePage(noteModel: state.arrNotes[index],)));
                    },
                  );
                });
          }
          return Container();
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddNotePage()));
          },
          child: const Icon(Icons.add),
        ));
  }
}
