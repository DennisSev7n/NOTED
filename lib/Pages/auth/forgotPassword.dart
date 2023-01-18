import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
   final _emailController = TextEditingController();

   @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
  }

  Future passwordReset() async{
    try{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
    showDialog(context: context, builder: (context){
      return const AlertDialog(
        content: Text("Password reset link sent! check your email"),
      );
    });
  } on FirebaseAuthException catch (e) {
    print(e);

    showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Text(e.message.toString()),
      );
    });
  }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurple,
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
                  color:Colors.blueGrey[700]
                )
              )
            ],
          ),
        ),
        centerTitle: true,
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text("Enter your Email and we will send you a rest link",
            textAlign: TextAlign.center,),
          ),
          
          const SizedBox(
            height: 10,
          ),

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
          child: TextField(
            controller: _emailController,
decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "Email", 
          filled: true,
),
          ),
        ),
      ),
    ),

     const SizedBox(
            height: 10,
          ),

    MaterialButton(onPressed: passwordReset,
    color: Colors.deepPurple[200],
    child: const Text("Reset Password"),
    )
    
        ],
      ), 
    );
    
  }
}