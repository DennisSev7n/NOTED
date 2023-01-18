
import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hand_bag/appStyle.dart';
import 'package:image_picker/image_picker.dart';

class ImgToText extends StatefulWidget {
  const ImgToText({Key? key}) : super(key: key);
  

  @override
  State<ImgToText> createState() => _ImgToTextState();
}

class _ImgToTextState extends State<ImgToText> {
 

Future getImage(ImageSource source) async{
    try{
      final pickedImage = await ImagePicker.platform.pickImage(source: source);
      if(pickedImage != null){
        textScanning = true;
         
        setState(() {
          imageFile = File(pickedImage.path);
        });

        getRecognisedText(imageFile!);
      }
    } catch(e){
      textScanning = false;
      imageFile = null;
      setState(() {
        
      });
      scannedText = "Error occured while scanning";
    }
  }


   Future getRecognisedText(File image) async{
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = GoogleMlKit.vision.textDetector();
    RecognisedText recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText = "";
    for(TextBlock block in recognisedText.blocks){
      for (TextLine line in block.lines){
        scannedText = "$scannedText${line.text}\n";
      }
    }
    textScanning = false;
    setState(() {
      
    });
  }










  int color_id = Random().nextInt(AppStyle.cardColor.length);
  String scannedText = "";
   bool textScanning = false;
   File? imageFile;
  @override
  Widget build(BuildContext context) {
     // ignore: unused_element
     _copy(){
      final value = ClipboardData(text: scannedText);
    Clipboard.setData(value);
  }
    return Scaffold(
      backgroundColor: AppStyle.cardColor[color_id],
      appBar: AppBar( automaticallyImplyLeading: false,
        backgroundColor: AppStyle.cardColor[color_id],
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("Image To Text", style: TextStyle(
          color: Colors.black,
          fontSize: 20
        ),),
        centerTitle: true,

      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Text("Convert Image To Text", style: GoogleFonts.nunito(color: Colors.black)),
            const SizedBox(
              height: 50,
            ),
      
            if(textScanning) const CircularProgressIndicator(),
            imageFile != null ?
             Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                         
                          height: 300,
                          width: MediaQuery.of(context).size.width,
                          child:  ClipRRect(
                             borderRadius: BorderRadius.circular(6),
                            child: Image.file(File(imageFile!.path),fit: BoxFit.cover,)),
             ):
          // !textScanning && imageFile == null ?
             Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(6)
                          ),
                          height: 300,
                          width: MediaQuery.of(context).size.width,
             ),
      
             
             
             
      
             const SizedBox(
              height: 20,
             ),
      
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(onPressed: (){
                  getImage(ImageSource.gallery);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.grey,
                  shadowColor: Colors.grey[400],
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)
                  )
                ),
                 icon: Icon(Icons.image), 
                 label: Text("Gallery")
                 ),
      
                 const SizedBox(
                  width: 10,
                 ),
      
                 ElevatedButton.icon(onPressed: (){
                  getImage(ImageSource.camera);
                 },
                  style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.grey,
                  shadowColor: Colors.grey[400],
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)
                  )
                ),
                  icon: const Icon(Icons.camera_alt),
                   label: Text("Camera"))
      
              ],
             ),
      
             const SizedBox(
              height: 10,
             ),
      
             Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                scannedText,
                style: AppStyle.mainContent,
      
              ),
             )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(onPressed: (() {
        _copy();
      }),
      backgroundColor: AppStyle.cardColor[color_id],
      child: const Icon(Icons.copy, color: Colors.black,),
      ),
    );
  }

 
  
}