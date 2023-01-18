import 'package:flutter/material.dart';
import 'package:hand_bag/Pages/auth/Authentication.dart';

import 'Pages/homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}



class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigateHome();

  }

   _navigateHome() async{
    await Future.delayed(Duration(milliseconds: 1500), (){});

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Authentication()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.deepPurple[400],

      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "NO",
              style: TextStyle(
                fontSize:34,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
            Text(
              "TED",
              style: TextStyle(
                fontSize:34,
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
    );
  }
}