import 'package:cubit_with_sqflite/app_database.dart';
import 'package:cubit_with_sqflite/note_cubit/note_state.dart';
import 'package:cubit_with_sqflite/note_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteCubit extends Cubit<NoteState>{
  AppDataBase db;
  NoteCubit({required this.db}):super(NoteInitialState());

  // db methods
  void addNotes(NoteModel newNote) async{
    emit(NoteLoadingState());

    bool check = await db.addNote(newNote);

    if(check){
      var notes = await db.fetchAllNotes();
      emit(NoteLoadedState(arrNotes: notes));
    } else {
      emit(NoteErrorState(errorMsg: "Note not added"));
    }

  }

  void getAllNotes() async {
    emit(NoteLoadingState());
    var notes = await db.fetchAllNotes();
    emit(NoteLoadedState(arrNotes: notes));
  }

  void updateNote(NoteModel updatedNote) async {
    emit(NoteLoadingState());
    bool check = await db.updateNote(updatedNote);
    if(check){
      var notes = await db.fetchAllNotes();
      emit(NoteLoadedState(arrNotes: notes));
    } else {
      emit(NoteErrorState(errorMsg: "Note is not updated"));
    }
  }

  void deleteNote(int note_id) async {
    emit(NoteLoadingState());
    bool check = await db.deleteNote(note_id);
    if(check){
      var notes = await db.fetchAllNotes();
      emit(NoteLoadedState(arrNotes: notes));
    } else {
      emit(NoteErrorState(errorMsg: "Note is not deleted"));
    }
    
  }
}