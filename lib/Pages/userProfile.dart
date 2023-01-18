import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hand_bag/Pages/auth/Authentication.dart';
import 'package:hand_bag/Pages/auth/loginPage.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  // var email = FirebaseAuth.instance.currentUser!.email;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
appBar: AppBar(
   automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.deepPurple[400],
        actions: [
          GestureDetector(
            onTap: (){
              FirebaseAuth.instance.signOut();
              FirebaseAuth.instance.signOut().whenComplete(() => Navigator.push(context, MaterialPageRoute(builder: ((context) => Authentication() ))));
            },
            child: const Icon(Icons.logout, color: Colors.black54,),
          )
        ],
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
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

body: StreamBuilder<DocumentSnapshot<Object?>>(
  stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid.toString()).snapshots(),
  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
     if(snapshot.connectionState == ConnectionState.waiting){
                            return  const Center(child: CircularProgressIndicator(
                               color: Colors.deepPurpleAccent,
                           ));
                          }

                           if(snapshot.hasData){
                             Map<String, dynamic>? data = snapshot.data.data() as Map<String, dynamic>;
              return
    
       Center(
    
      child: SingleChildScrollView(
    
        child: Column(
    
          mainAxisAlignment: MainAxisAlignment.center,
    
          children: [
    
           data.isNotEmpty?
           Column(
            children: [
                Text(
                 "Email: "+data['email'], 
                   style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 22
                    )
                   
                   ,
                ),

                Text(
                  "${"Name: " +data['first name']} " + data['last name'],
                  style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 22
                )
                ) 
            ]

           ):
           Column(
            children: [
               Text(
                 "Email: ", 
                   style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 22
                    )
                   
                   ,
                ),

                Text(
                  "Name: ",
                  style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 22
                )
                ) 
            ],
           )
    
              ],
    
            )
    
       
    
      ),
    
    );
}
return Container(
  child: Text("No Data Available",  style: GoogleFonts.nunito(color: Colors.black),));
  }


) ,
    );
  }
}