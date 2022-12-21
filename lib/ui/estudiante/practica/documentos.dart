import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

class DocumentsCopyPage extends StatefulWidget {
  const DocumentsCopyPage({Key? key}) : super(key: key);

  @override
  State<DocumentsCopyPage> createState() => _DocumentsCopyPageState();
}


class _DocumentsCopyPageState extends State<DocumentsCopyPage> {
  UploadTask? task;
  UploadTask? task1;
  UploadTask? task2;
  UploadTask? task3;
  UploadTask? task4;
  File? file;
  File? file1;
  File? file2;
  File? file3;
  File? file4;

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'Ningun Archivo';
    final fileName1 = file1 != null ? basename(file1!.path) : 'Ningun Archivo';
    final fileName2 = file2 != null ? basename(file2!.path) : 'Ningun Archivo';
    final fileName3 = file3 != null ? basename(file3!.path) : 'Ningun Archivo';
    final fileName4 = file4 != null ? basename(file4!.path) : 'Ningun Archivo';

    // if (fileName.length>10) {
    //   print(fileName.substring(0,10));
    // }
    // else{
    //   print(fileName);
    // }

    String? fileNameCondicional = (fileName.length > 15)? fileName.substring(0,15):fileName;
    String? fileNameCondicional1 = (fileName1.length > 15)? fileName1.substring(0,15):fileName1;
    String? fileNameCondicional2 = (fileName2.length > 15)? fileName2.substring(0,15):fileName2;
    String? fileNameCondicional3 = (fileName3.length > 15)? fileName3.substring(0,15):fileName3;
    String? fileNameCondicional4 = (fileName4.length > 15)? fileName4.substring(0,15):fileName4;
    

    return Scaffold(
      appBar: AppBar(
        title: Text('Subir Documentos'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top:15),
          child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 10.0, top: 3.0, bottom: 3.0, right: 3.0),
                      padding: const EdgeInsets.only(left: 12.0, top: 10.0, bottom: 10.0, right: 12.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color.fromARGB(255, 61, 61, 61), width: 1.0,),
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color.fromARGB(255, 244, 250, 255),
                            Color.fromARGB(255, 184, 184, 184),
                          ],
                        )
                      ),
                        child: Column(
                          mainAxisAlignment:  MainAxisAlignment.center,
                          children: [
                            Text('CARTA DE PRESENTACIÓN', style: TextStyle(fontSize: 20, fontFamily: 'Raleway', fontWeight: FontWeight.w700), textAlign: TextAlign.center,),
                            const SizedBox(height: 8),
                            Image.asset('assets/pdf.png', 
                            width: 200,
                            height: 100,),
                            const SizedBox(height: 5),
                            Text(
                              fileNameCondicional,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500), textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            ButtonWidget(
                              text: 'Subir',
                              icon: Icons.attach_file,
                              onClicked: selectFile,
                            ),
                            const SizedBox(height: 4),
                            ButtonWidget(
                              text: 'Enviar',
                              icon: Icons.cloud_upload_outlined,
                              onClicked: uploadFile,
                            ),
                            const SizedBox(height: 4),
                            task != null ? buildUploadStatus(task!) : Container(),
                          ],
                        )
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 3.0, top: 3.0, bottom: 3.0, right: 10.0),
                      padding: const EdgeInsets.only(left: 12.0, top: 10.0, bottom: 10.0, right: 12.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color.fromARGB(255, 61, 61, 61), width: 1.0,),
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color.fromARGB(255, 244, 250, 255),
                            Color.fromARGB(255, 184, 184, 184),
                          ],
                        )
                      ),
                        child: Column(
                          mainAxisAlignment:  MainAxisAlignment.center,
                          children: [
                            Text('CARTA DE ACEPTACIÓN', style: TextStyle(fontSize: 20, fontFamily: 'Raleway', fontWeight: FontWeight.w700), textAlign: TextAlign.center,),
                            const SizedBox(height: 8),
                            Image.asset('assets/pdfplomo.png', 
                            width: 200,
                            height: 100,),
                            const SizedBox(height: 5),
                            Text(
                              fileNameCondicional1,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500), textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            ButtonWidget(
                              text: 'Subir',
                              icon: Icons.attach_file,
                              onClicked: selectFile1,
                            ),
                            const SizedBox(height: 4),
                            ButtonWidget(
                              text: 'Enviar',
                              icon: Icons.cloud_upload_outlined,
                              onClicked: uploadFile1,
                            ),
                            const SizedBox(height: 4),
                            task1 != null ? buildUploadStatus1(task1!) : Container(),
                          ],
                        )
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 3.0, right: 3.0),
                      padding: const EdgeInsets.only(left: 12.0, top: 10.0, bottom: 10.0, right: 12.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color.fromARGB(255, 61, 61, 61), width: 1.0,),
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color.fromARGB(255, 244, 250, 255),
                            Color.fromARGB(255, 184, 184, 184),
                          ],
                        )
                      ),
                        child: Column(
                          mainAxisAlignment:  MainAxisAlignment.center,
                          children: [
                            Text('CONVENIO DE PRACTICAS', style: TextStyle(fontSize: 20, fontFamily: 'Raleway', fontWeight: FontWeight.w700), textAlign: TextAlign.center,),
                            const SizedBox(height: 8),
                            Image.asset('assets/pdfplomo.png', 
                            width: 200,
                            height: 100,),
                            const SizedBox(height: 5),
                            Text(
                              fileNameCondicional2,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500), textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            ButtonWidget(
                              text: 'Subir',
                              icon: Icons.attach_file,
                              onClicked: selectFile2,
                            ),
                            const SizedBox(height: 4),
                            ButtonWidget(
                              text: 'Enviar',
                              icon: Icons.cloud_upload_outlined,
                              onClicked: uploadFile2,
                            ),
                            const SizedBox(height: 4),
                            task2 != null ? buildUploadStatus2(task2!) : Container(),
                          ],
                        )
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 3.0, top: 10.0, bottom: 3.0, right: 10.0),
                      padding: const EdgeInsets.only(left: 12.0, top: 10.0, bottom: 10.0, right: 12.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color.fromARGB(255, 61, 61, 61), width: 1.0,),
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color.fromARGB(255, 244, 250, 255),
                            Color.fromARGB(255, 184, 184, 184),
                          ],
                        )
                      ),
                        child: Column(
                          mainAxisAlignment:  MainAxisAlignment.center,
                          children: [
                            Text('PLAN DE PRACTICAS', style: TextStyle(fontSize: 20, fontFamily: 'Raleway', fontWeight: FontWeight.w700), textAlign: TextAlign.center,),
                            const SizedBox(height: 8),
                            Image.asset('assets/pdfplomo.png', 
                            width: 200,
                            height: 100,),
                            const SizedBox(height: 5),
                            Text(
                              fileNameCondicional3,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500), textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            ButtonWidget(
                              text: 'Subir',
                              icon: Icons.attach_file,
                              onClicked: selectFile3,
                            ),
                            const SizedBox(height: 4),
                            ButtonWidget(
                              text: 'Enviar',
                              icon: Icons.cloud_upload_outlined,
                              onClicked: uploadFile3,
                            ),
                            const SizedBox(height: 4),
                            task3 != null ? buildUploadStatus3(task3!) : Container(),
                          ],
                        )
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 3.0, right: 3.0),
                      padding: const EdgeInsets.only(left: 12.0, top: 10.0, bottom: 10.0, right: 12.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color.fromARGB(255, 61, 61, 61), width: 1.0,),
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color.fromARGB(255, 244, 250, 255),
                            Color.fromARGB(255, 184, 184, 184),
                          ],
                        )
                      ),
                        child: Column(
                          mainAxisAlignment:  MainAxisAlignment.center,
                          children: [
                            Text('CONSTANCIA DE EVALUACIÓN', style: TextStyle(fontSize: 20, fontFamily: 'Raleway', fontWeight: FontWeight.w700), textAlign: TextAlign.center,),
                            const SizedBox(height: 8),
                            Image.asset('assets/pdfplomo.png', 
                            width: 200,
                            height: 100,),
                            const SizedBox(height: 5),
                            Text(
                              fileNameCondicional4,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500), textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            ButtonWidget(
                              text: 'Subir',
                              icon: Icons.attach_file,
                              onClicked: selectFile4,
                            ),
                            const SizedBox(height: 4),
                            ButtonWidget(
                              text: 'Enviar',
                              icon: Icons.cloud_upload_outlined,
                              onClicked: uploadFile4,
                            ),
                            const SizedBox(height: 4),
                            task4 != null ? buildUploadStatus4(task4!) : Container(),
                          ],
                        )
                    ),
                  ),
                  Expanded(
                    child: Container(
                      
                    ),
                  ),
                ],
              ),
              
            ],
          ),
          
        ),
        ),
      ),
      
    );
  }


//SELECTS

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future selectFile1() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file1 = File(path));
  }

  Future selectFile2() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file2 = File(path));
  }

  Future selectFile3() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file3 = File(path));
  }

  Future selectFile4() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file4 = File(path));
  }




//UPLOAD

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = '$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
  }

  Future uploadFile1() async {
    if (file1 == null) return;

    final fileName1 = basename(file1!.path);
    final destination = '$fileName1';

    task1 = FirebaseApi.uploadFile(destination, file1!);
    setState(() {});

    if (task1 == null) return;

    final snapshot = await task1!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
  }

  Future uploadFile2() async {
    if (file2 == null) return;

    final fileName2 = basename(file2!.path);
    final destination = '$fileName2';

    task2 = FirebaseApi.uploadFile(destination, file2!);
    setState(() {});

    if (task2 == null) return;

    final snapshot = await task2!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
  }

  Future uploadFile3() async {
    if (file3 == null) return;

    final fileName3 = basename(file3!.path);
    final destination = '$fileName3';

    task3 = FirebaseApi.uploadFile(destination, file3!);
    setState(() {});

    if (task3 == null) return;

    final snapshot = await task3!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
  }

  Future uploadFile4() async {
    if (file4 == null) return;

    final fileName4 = basename(file4!.path);
    final destination = '$fileName4';

    task4 = FirebaseApi.uploadFile(destination, file4!);
    setState(() {});

    if (task4 == null) return;

    final snapshot = await task4!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
  }



  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
    stream: task.snapshotEvents,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final snap = snapshot.data!;
        final progress = snap.bytesTransferred / snap.totalBytes;
        final percentage = (progress * 100).toStringAsFixed(2);

        return Text(
          '$percentage %',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 7, 82, 65),),
        );
      } else {
        return Container();
      }
    },
  );
  Widget buildUploadStatus1(UploadTask task1) => StreamBuilder<TaskSnapshot>(
    stream: task1.snapshotEvents,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final snap = snapshot.data!;
        final progress = snap.bytesTransferred / snap.totalBytes;
        final percentage = (progress * 100).toStringAsFixed(2);

        return Text(
          '$percentage %',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 7, 82, 65),),
        );
      } else {
        return Container();
      }
    },
  );
  Widget buildUploadStatus2(UploadTask task2) => StreamBuilder<TaskSnapshot>(
    stream: task2.snapshotEvents,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final snap = snapshot.data!;
        final progress = snap.bytesTransferred / snap.totalBytes;
        final percentage = (progress * 100).toStringAsFixed(2);

        return Text(
          '$percentage %',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 7, 82, 65),),
        );
      } else {
        return Container();
      }
    },
  );
  Widget buildUploadStatus3(UploadTask task3) => StreamBuilder<TaskSnapshot>(
    stream: task3.snapshotEvents,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final snap = snapshot.data!;
        final progress = snap.bytesTransferred / snap.totalBytes;
        final percentage = (progress * 100).toStringAsFixed(2);

        return Text(
          '$percentage %',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 7, 82, 65),),
        );
      } else {
        return Container();
      }
    },
  );
  Widget buildUploadStatus4(UploadTask task4) => StreamBuilder<TaskSnapshot>(
    stream: task4.snapshotEvents,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final snap = snapshot.data!;
        final progress = snap.bytesTransferred / snap.totalBytes;
        final percentage = (progress * 100).toStringAsFixed(2);

        return Text(
          '$percentage %',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 7, 82, 65),),
        );
      } else {
        return Container();
      }
    },
  );
}

class ButtonWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: Color.fromARGB(255, 41, 41, 41),
      minimumSize: const Size.fromHeight(47),
    ),
    onPressed: onClicked,
    child: buildContent(),
    
  );

  Widget buildContent() => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: 28),
      const SizedBox(width: 16),
      Text(
        text,
        style: const TextStyle(fontSize: 22, color: Colors.white),
      ),
    ],
  );
}

class FirebaseApi {
  static UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  static UploadTask? uploadBytes(String destination, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putData(data);
    } on FirebaseException catch (e) {
      return null;
    }
  }
}