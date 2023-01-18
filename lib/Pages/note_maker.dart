import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hand_bag/Pages/Image_to_text.dart';
import 'package:hand_bag/appStyle.dart';
import 'package:intl/intl.dart';

import 'homepage.dart';


class NoteEditor extends StatefulWidget {
  const NoteEditor({Key? key}) : super(key: key);

  @override
  State<NoteEditor> createState() => _NoteEditorState();
}

class _NoteEditorState extends State<NoteEditor> {

  @override
  Widget build(BuildContext context) {
    int color_id = Random().nextInt(AppStyle.cardColor.length);
    String date = DateFormat('dd-MM-yyyy').format(DateTime.now());
    TextEditingController _titleController = TextEditingController();
    TextEditingController _mainController = TextEditingController();
     bool _isLoading = false;
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

        actions: [
          ElevatedButton.icon(onPressed: (){
            // ignore: prefer_const_constructors
            Navigator.push(context, MaterialPageRoute(builder:(context) =>ImgToText() ,));
          }, 
          icon: const Icon(Icons.camera_alt, color: Colors.black,),
          style: ElevatedButton.styleFrom(
            primary: AppStyle.cardColor[color_id],
            shadowColor: AppStyle.cardColor[color_id],
            elevation: 0.0
          ),
           label: const Text(""))
        ],
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
          onPressed: () async{
            FirebaseFirestore.instance.collection("notes").add({
              "note_title": _titleController.text,
              "creation_date": date,
              "note_content":_mainController.text,
              "color_id": color_id,
              'user_id': FirebaseAuth.instance.currentUser!.uid,
            }).then((value) {
              print(value.id);
              Navigator.pop(context);
            }).catchError(
              (error) => print("failed to Save new Note due to $error")
            
            );
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home()));
            
            
            //. catchError((error)=> print("Failed to save new note due to $error"));
        },
        backgroundColor: AppStyle.cardColor[color_id],
        child: const Icon(Icons.save_alt, color: Colors.black,),
        
        ),
    );
  }
}