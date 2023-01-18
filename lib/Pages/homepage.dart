// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hand_bag/Pages/note_card.dart';
import 'package:hand_bag/Pages/note_maker.dart';
import 'package:hand_bag/Pages/note_reader.dart';
import 'package:hand_bag/Pages/userProfile.dart';
import 'package:hand_bag/pdfReader/pdfHome.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   var currentUser = FirebaseAuth.instance.currentUser;
   String name  = "";

   ScrollController scrollController = ScrollController();
  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

   Future <dynamic> reFresh()async{
    return await Container(
      child: StreamBuilder <QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("notes").where("user_id", isEqualTo: currentUser!.uid).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                      if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator() ,
              );
            }else {
              return GridView(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2
                                ),
                                children: snapshot.data!.docs.map((notes)=> noteCard((){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => NoteReader(notes),));
                                }, notes)).toList() 
                                  
                                ,
                              );
            }
        }
        ),
    );
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.deepPurple[400],
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "NO",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "TED",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[700]
                ),
              ),
              Icon(Icons.drive_file_rename_outline,
              color: Colors.blueGrey[700]
              )
            ],
          ),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Card(
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.grey[300],
                      focusColor: Colors.deepPurple[400],
                      prefixIcon: Icon(Icons.search), 
                      hintText: "Search...",
                    ),
                    onChanged: (val){
                      setState(() {
                        name = val;
                      });
                    },
                  ),
                )
              ),

                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: (name != "" && name != null)
                        ? FirebaseFirestore.instance.collection("notes").where("user_id", isEqualTo: currentUser!.uid).where("note_title", isEqualTo: name).snapshots()
                         :FirebaseFirestore.instance.collection("notes").where("user_id", isEqualTo: currentUser!.uid).snapshots(),
                        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return  Column(
                          
                              children: [
                                Center(child: CircularProgressIndicator(
                                   color: Colors.deepPurpleAccent,
                           )),
                           
                              ],
                            );
                          }
                          
                         
                          //    return  GridView(
                          //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          //       crossAxisCount: 2
                          //       ),
                          //       children: snapshot.data!.docs.map((notes)=> noteCard((){
                          //         Navigator.push(context, MaterialPageRoute(builder: (context) => NoteReader(notes),));
                          //       }, notes)).toList() 
                                  
                          //       ,
                          //     );
                           
                          // }
                         
                if(snapshot.hasData){        
              return LiquidPullToRefresh(
                color: Colors.deepPurple[400],
                backgroundColor: Colors.deepPurple[200],
                height: 100,
                animSpeedFactor: 2,
                showChildOpacityTransition: false,
                onRefresh: reFresh,
                child:  GridView(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2
                                ),
                                children: snapshot.data!.docs.map((notes)=> noteCard((){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => NoteReader(notes),));
                                }, notes)).toList() 
                                  
                                ,
                              )
              );
                          
                          
                           
                       
                        
                         }
                         
                         
                         else if(!snapshot.hasData){
                               return Center(child: Text("No Notes Available", style: GoogleFonts.nunito(color: Colors.black),));
                        
                          }

                          return Container(child: Center(child: Text("No Notes Available", style: GoogleFonts.nunito(color: Colors.black),)),);
                        }
                      

                          
                        
                      ),
                    )
            ],
          ),
        ),
      ),


      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> NoteEditor()));
      }, 
      backgroundColor: Colors.deepPurple[400],
      child: Icon(Icons.add),
      
       ),

       bottomNavigationBar: 
        BottomAppBar(
        
        shape: CircularNotchedRectangle(),
        notchMargin: 12,
        child: Container(
          height: 60,
          child: Padding(padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=> PdfHome()));
   },
   icon: Icon(Icons.picture_as_pdf)),
              IconButton(onPressed: (){
                                 Navigator.push(context, MaterialPageRoute(builder: (context)=> UserProfile()));
              }, icon: Icon(Icons.person))
            ],
          ),),
        ),
      ),
       
    );
  }
}