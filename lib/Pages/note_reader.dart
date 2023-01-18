import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hand_bag/Pages/note.editor.dart';
import 'package:hand_bag/appStyle.dart';
import 'package:share/share.dart';

// ignore: must_be_immutable
class NoteReader extends StatefulWidget {
   NoteReader(this.doc, {Key? key}) : super(key: key);
   QueryDocumentSnapshot doc;

  @override
  State<NoteReader> createState() => _NoteReaderState();
}

class _NoteReaderState extends State<NoteReader> {
  
  @override
  Widget build(BuildContext context) {
    int color_id = widget.doc['color_id'];
    return Scaffold(
      backgroundColor:  AppStyle.cardColor[color_id],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: AppStyle.cardColor[color_id],

        actions: [
          const Padding(padding: EdgeInsets.all(10)),
          ElevatedButton.icon(onPressed: (() {
             FirebaseFirestore.instance
                            .collection("notes")
                            .doc(widget.doc.id)
                            .delete();
                      Navigator.pop(context);
          }),
          icon: const Icon(Icons.delete, size: 22, color: Colors.black,), 
          style: ElevatedButton.styleFrom(
            primary: AppStyle.cardColor[color_id],
            shadowColor: AppStyle.cardColor[color_id],
            elevation: 0.0
          ),
          
          label: const Text("")
          ),

          ElevatedButton.icon(onPressed: (){
            Share.share(widget.doc['note_content']);
          }, 
          icon: const Icon(Icons.share, color: Colors.black,),
           style: ElevatedButton.styleFrom(
            primary: AppStyle.cardColor[color_id],
            shadowColor: AppStyle.cardColor[color_id],
            elevation: 0.0
          ),
           label: const Text("")
           )
          
        ],
      ),

      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
               widget.doc["note_title"],
                style: AppStyle.mainTitle,
              ),
              const SizedBox(
                height: 4.0 ,
              ),
              Text(
                widget.doc["creation_date"],
                style: AppStyle.dateTitle,
              ),
              const SizedBox(
                height: 30.0 ,
              ),
              Text(
                widget.doc["note_content"],
                style: AppStyle.mainContent,
                
              )
            ],
          ),
        ),
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
           Navigator.push(context, MaterialPageRoute(builder: (context)=> NoteEdit(docToEdit: widget.doc )));
          }),
      
      
       backgroundColor: AppStyle.cardColor[color_id],
      child: const Icon(Icons.edit, color: Colors.black,),

    ));
  }
}