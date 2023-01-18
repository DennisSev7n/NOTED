import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hand_bag/Pages/homepage.dart';


class SignUp extends StatefulWidget {
   final VoidCallback showLoginPage;
   SignUp({Key? key, required this.showLoginPage}) : super(key: key);
    var currentUser = FirebaseAuth.instance.currentUser;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
     _emailController.dispose();
   _passwordController.dispose();
   confirmpasswordController.dispose();
   _firstnameController.dispose();
   _lastnameController.dispose();
    super.dispose();
  }


  

  Future addUserDetails(String firstName, String lastName,  String email, ) async{
   await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid.toString()).set({
     'first name': firstName,
     'last name': lastName ,
     'email': email,
   }) ;
  }
  

  

   Future signUp() async{
    
    bool isvalid;
    isvalid = _formKey.currentState!.validate();

   if (isvalid){
    

     showDialog(context: context,
     builder:(context){
       return const Center(child: CircularProgressIndicator(
         color: Colors.deepPurpleAccent,
       ));
     }
     );

     // create user
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailController.text.trim(), 
      password: _passwordController.text.trim());


      //add user details
      addUserDetails(
        _firstnameController.text,
       _lastnameController.text,
       _emailController.text,
  );
  
   }
//pop loading circle
 Navigator.of(context).pop();
  
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.grey[300],

      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
        
              children: [
        
                const SizedBox(
              height: 75,
            ),
              //Hello Again
              
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "NO",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 70
                  ),
                ),
                Text(
                  "TED",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[700],
                    fontSize: 70,
                  ),
                ),
                Icon(Icons.drive_file_rename_outline,
                color: Colors.deepPurple[700],
                size: 70,
                )
              ],
            ),
        
             const SizedBox(
          height: 10,
              ),
              
          //  Text("Your HandBag In The Palm Of Your Hand", style: GoogleFonts.bebasNeue(
          //    fontSize: 30,
             
          // ),),
              
        
              const SizedBox(
          height: 10,
              ),
            
            Text("Register below with your details", style: GoogleFonts.bebasNeue( fontSize: 24),),
        
            const SizedBox(
          height: 50,
              ),
            
            
            
            
            
            
            //first name textfiled
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(12)
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: TextFormField(
              validator: (_firstnameController) {
                if(_firstnameController == null || _firstnameController.isEmpty){
                  return "Can't be empty";
                }
                if(_firstnameController.length  < 2){
                  return "Too short";
                }
                return null;
              },
              controller: _firstnameController,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "First Name", 
             hintStyle: GoogleFonts.nunito(), 
            filled: true,
        ),
            ),
          ),
              ),
            ),
               
            const SizedBox(
              height: 10,
            ),
            //last name textfield
        
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(12)
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: TextFormField(
              controller: _lastnameController,
                validator: (_lastnameController) {
                if(_lastnameController == null || _lastnameController.isEmpty){
                  return "Can't be empty";
                }
                if(_lastnameController.length  < 2){
                  return "Too short";
                }
                return null;
              },
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Last Name", 
             hintStyle: GoogleFonts.nunito(), 
            filled: true,
        ),
            ),
          ),
              ),
            ),
        
        
        
        
        
        
            const SizedBox(
              height: 10,
            ),
              //Email textfield
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(12)
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: TextFormField(
                validator: (_emailController) {
                if(_emailController == null || _emailController.isEmpty){
                  return "Can't be empty";
                }
                if(!_emailController.characters.contains("@")){
                  return "Invalid Email";
                }
                return null;
              },
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            border: InputBorder.none,
            
            hintText: "Email", 
             hintStyle: GoogleFonts.nunito(), 
            filled: true,
        ),
            ),
          ),
              ),
            ),
            
            
            
            
            const SizedBox(
              height: 10,
            ),
              ///password textfield
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(12)
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: TextFormField(
                validator: (_passwordController) {
                if(_passwordController == null || _passwordController.isEmpty){
                  return "Can't be empty";
                }
                if(_passwordController.length  < 7){
                  return "Password too short";
                }
                return null;
              },
              controller: _passwordController,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Password,",
            hintStyle: GoogleFonts.nunito(), 
            filled: true,
        ),
            ),
          ),
              ),
            ),
        
            // confirm password textfield
        
             const SizedBox(
              height: 10,
            ),
              ///password textfield
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(12)
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: TextFormField(
                validator: (value) {
                if( value !=_passwordController.text){
                  return "Password does'nt match";
                }
                return null;
              },
              controller: confirmpasswordController,
              obscureText: true,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: " Confirm Password", 
             hintStyle: GoogleFonts.nunito(),  
            filled: true,
        ),
            ),
          ),
              ),
            ),
              
            
            
            
            
            const SizedBox(
              height: 10,
            ),
              //sign in button
              Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: GestureDetector(
            onTap: signUp,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.deepPurple[700],
              borderRadius: BorderRadius.circular(12)),
        child: const Center(child: Text("Sign Up",
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),)),
            ),
          ),
              ),
        
         const SizedBox(
              height: 25,
            ),
            
              //not a member? register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
          const Text("Already a member? ", style: TextStyle( fontWeight: FontWeight.bold)),
        
          GestureDetector(
            onTap: widget.showLoginPage ,
            child: const Text("Login", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),))
              ],
            ),
        SizedBox(
          height: 20,
        )
        
              ],
            ),
          ),
        ),
      ),
    );
  }
}