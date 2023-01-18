import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hand_bag/Pages/auth/forgotPassword.dart';

class Login extends StatefulWidget {
   final VoidCallback showRegisterPage;
  const Login({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
  //text controllers
 final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

 

  Future signIn() async{
    
    bool isvalid;
    isvalid = _formKey.currentState!.validate();
    if(isvalid){

      _formKey.currentState?.save();
          //loading circle
    showDialog(context: context,
     builder:(context){
       return const Center(child: CircularProgressIndicator(
         color: Colors.deepPurpleAccent,
       ));
     }
     );
     
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim())
     .catchError((error){
      showDialog(context: context,
       builder: (context){
        return AlertDialog(
          title: const Text("Login Error"),
          content: Text("Email or password is incorrect"),
          actions: [
            FlatButton(onPressed: (){
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            }, 
            child: const Text("Ok", style: TextStyle(
              color: Colors.deepPurple
            ),)
            )
          ],
        );
       }
       );
    });
     
    
//pop the loading circle
Navigator.of(context).pop();
    }

  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300]  ,
body: Center(
  child:   Form(
    key: _formKey,
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
         children: [ 
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
        height: 75,
      ),
        //Hello Again
        Text("Hello Again!", style: GoogleFonts.bebasNeue(
           fontSize: 52,
        ),),
  
        const SizedBox(
          height: 10,
        ),
      
      Text("Welcome back! you\'ve been missed", style: GoogleFonts.bebasNeue( fontSize: 24),),
  
      const SizedBox(
          height: 50,
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
              validator: (value) {
                if(value == null || value.isEmpty){
                  return "Can't be empty";
                }
                return null;
              },
              controller: _emailController,
  decoration:  InputDecoration(
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
              controller: _passwordController,
              validator: (value){
                if(value ==null || value.isEmpty){
                  return "Can't be empty";
                }
                return null;
              },
              obscureText: true,
  decoration:  InputDecoration(
            border: InputBorder.none,
            hintText: "Password", 
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
  
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap:(){ Navigator.push(context, MaterialPageRoute(builder: (context){
                return const ForgotPassword();
              }));},
              child: const Text("Forgot Password?", style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold
              ),),
            ),
          ],
        ),
      ),
        
      
      
      
      
      const SizedBox(
        height: 10,
      ),
        //sign in button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: GestureDetector(
            onTap: signIn,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.deepPurple[700],
              borderRadius: BorderRadius.circular(12)),
  child: const Center(child: Text("Sign in",
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
          const Text("Not a member? ", style: TextStyle( fontWeight: FontWeight.bold)),
  
          GestureDetector(
            onTap: widget.showRegisterPage ,
            child: const Text("Register Now", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),))
        ],
      )
      
      
      ],
      
      ),
    ),
  ),
)
    );
  }
}