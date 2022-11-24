import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note1/style/app_style.dart';

class NoteEditorScree extends StatefulWidget {
  const NoteEditorScree({Key? key}) : super(key: key);

  @override
  State<NoteEditorScree> createState() => _NoteEditorScreeState();
}

class _NoteEditorScreeState extends State<NoteEditorScree> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _mainController = TextEditingController();
   String date= DateTime.now().toString();
  int color_id = Random().nextInt(AppStyle.CardsColor.length);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.CardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.CardsColor[color_id],
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Add a new note',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Title',
              ),
              style: AppStyle.mainTitle,
            ),
            SizedBox(
              height: 8,
            ),
          Text(date,style: AppStyle.dateTitle,),
            SizedBox(height: 8.0,),
            TextField(
              controller: _mainController,
              keyboardType: TextInputType.multiline,
              maxLength: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Note content',
              ),
              style: AppStyle.mainContent,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.accentColor,
        onPressed: () async{
          FirebaseFirestore.instance.collection("Notes").add({
            "note_title":_titleController.text,
            "creation_date":date,
            "note_content":_mainController.text,
            "color_id":color_id,

          }).then((value) {
            print(value.id);
            Navigator.pop(context);}).catchError((error)=>print('Faield to add note $error'));
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
