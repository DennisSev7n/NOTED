import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';

class PdfHome extends StatefulWidget {
  const PdfHome({Key? key}) : super(key: key);

  @override
  State<PdfHome> createState() => _PdfHomeState();
}

class _PdfHomeState extends State<PdfHome> {
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

      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Center(child: Text("Pick PDF File", style: GoogleFonts.nunito(color: Colors.black),)),
          const SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () async{
              final result = await FilePicker.platform.pickFiles();
              if (result == null) return;

              // open single File
              final file = result.files.first;
              openFile(file);
            },
            child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(6)
                        ),
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        child: const Icon(Icons.add),
                      ),
          ),
        ],
      ),
    );
    
  }
  void openFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }
}