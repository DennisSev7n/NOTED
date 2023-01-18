// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../appStyle.dart';
import 'homepage.dart';

class NoteEdit extends StatefulWidget {
  DocumentSnapshot docToEdit;
  NoteEdit({
    Key? key,
    required this.docToEdit,
  }) : super(key: key);

  @override
  State<NoteEdit> createState() => _NoteEditState();
}

class _NoteEditState extends State<NoteEdit> {
  int color_id = Random().nextInt(AppStyle.cardColor.length);
    String date = DateFormat('dd-MM-yyyy').format(DateTime.now());
    TextEditingController _titleController = TextEditingController();
    TextEditingController _mainController = TextEditingController();

    @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _titleController = TextEditingController( text:widget.docToEdit["note_title"]);
    _mainController = TextEditingController(text:  widget.docToEdit["note_content"]);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.cardColor[color_id],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppStyle.cardColor[color_id],
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("Add a new Note", style: TextStyle(
          color: Colors.black
        ),),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  border:  InputBorder.none,
                  hintText: "Note Title"
                ),
                style: AppStyle.mainTitle,
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(date,
              style: AppStyle.dateTitle,),
              const SizedBox(
                height: 28,
              ),
      
                TextField(
                controller: _mainController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  border:  InputBorder.none,
                  hintText: "Note"
                ),
                style: AppStyle.mainContent,
              ),
            ],
          ),
          ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          widget.docToEdit.reference.update(
            {
               "note_title": _titleController.text,
              "creation_date": date,
              "note_content":_mainController.text,
              "color_id": color_id,
              'user_id': FirebaseAuth.instance.currentUser!.uid,
            }).whenComplete(() => Navigator.pop(context));
            
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home()));
            
            
            
            
          
      },
       backgroundColor: AppStyle.cardColor[color_id],
        child: const Icon(Icons.save_alt, color: Colors.black,),
        
      
      ),
    );
  }
}