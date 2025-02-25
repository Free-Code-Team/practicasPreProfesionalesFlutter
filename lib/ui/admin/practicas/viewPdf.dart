import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practicas_pre_profesionales_flutter/test/api/pdf_api.dart';
import 'package:practicas_pre_profesionales_flutter/test/comp/customAppBar.dart';
import 'package:practicas_pre_profesionales_flutter/ui/admin/drawer_admin.dart';
import 'package:practicas_pre_profesionales_flutter/ui/admin/practicas/pdf_viewer_page.dart';
import 'package:practicas_pre_profesionales_flutter/test/widget/button_widget.dart';
import 'package:http/http.dart' as http;

class ViewPdf extends StatefulWidget {
  const ViewPdf({Key? key}) : super(key: key);

  @override
  State<ViewPdf> createState() => _ViewPdfState();
}

class _ViewPdfState extends State<ViewPdf> {
  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: const DrawerAdmin(),
        appBar: AppBar(
          title: Text('Practicas'),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 15),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                            margin: const EdgeInsets.only(
                                left: 10.0, top: 3.0, bottom: 3.0, right: 3.0),
                            padding: const EdgeInsets.only(
                                left: 12.0,
                                top: 10.0,
                                bottom: 10.0,
                                right: 12.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(255, 61, 61, 61),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(5),
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Color.fromARGB(255, 244, 250, 255),
                                    Color.fromARGB(255, 184, 184, 184),
                                  ],
                                )),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'CARTA DE PRESENTACIÓN',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                Image.asset(
                                  'assets/pdf.png',
                                  width: 200,
                                  height: 100,
                                ),
                                const SizedBox(height: 5),
                                ButtonWidget(
                                  text: 'Abrir',
                                  icon: Icons.open_in_new,
                                  onClicked: () async {
                                    final url = 'files/carta de presentacion.pdf';
                                    final file = await PDFApi.loadFirebase(url);

                                    if (file == null) return;
                                    openPDF(context, file);
                                  },
                                ),
                              ],
                            )),
                      ),
                      Expanded(
                        child: Container(
                            margin: const EdgeInsets.only(
                                left: 3.0, top: 3.0, bottom: 3.0, right: 10.0),
                            padding: const EdgeInsets.only(
                                left: 12.0,
                                top: 10.0,
                                bottom: 10.0,
                                right: 12.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(255, 61, 61, 61),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(5),
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Color.fromARGB(255, 244, 250, 255),
                                    Color.fromARGB(255, 184, 184, 184),
                                  ],
                                )),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'CARTA DE ACEPTACIÓN',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                Image.asset(
                                  'assets/pdf.png',
                                  width: 200,
                                  height: 100,
                                ),
                                const SizedBox(height: 5),
                                ButtonWidget(
                                  text: 'Abrir',
                                  icon: Icons.open_in_new,
                                  onClicked: () async {
                                    final url =
                                        'files/carta de aceptación municipio.pdf';
                                    final file = await PDFApi.loadFirebase(url);

                                    if (file == null) return;
                                    openPDF(context, file);
                                  },
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                            margin: const EdgeInsets.only(
                                left: 10.0, top: 10.0, bottom: 3.0, right: 3.0),
                            padding: const EdgeInsets.only(
                                left: 12.0,
                                top: 10.0,
                                bottom: 10.0,
                                right: 12.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(255, 61, 61, 61),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(5),
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Color.fromARGB(255, 244, 250, 255),
                                    Color.fromARGB(255, 184, 184, 184),
                                  ],
                                )),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'CONVENIO DE PRACTICAS',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                Image.asset(
                                  'assets/pdfplomo.png',
                                  width: 200,
                                  height: 100,
                                ),
                                const SizedBox(height: 5),
                                ButtonWidget(
                                  text: 'Abrir',
                                  icon: Icons.open_in_new,
                                  onClicked: () async {
                                    final url = 'files/CONVENIO_DE_PPP.pdf';
                                    final file = await PDFApi.loadFirebase(url);

                                    if (file == null) return;
                                    openPDF(context, file);
                                  },
                                ),
                              ],
                            )),
                      ),
                      Expanded(
                        child: Container(
                            margin: const EdgeInsets.only(
                                left: 3.0, top: 10.0, bottom: 3.0, right: 10.0),
                            padding: const EdgeInsets.only(
                                left: 12.0,
                                top: 10.0,
                                bottom: 10.0,
                                right: 12.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(255, 61, 61, 61),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(5),
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Color.fromARGB(255, 244, 250, 255),
                                    Color.fromARGB(255, 184, 184, 184),
                                  ],
                                )),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'PLAN DE PRACTICAS',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                Image.asset(
                                  'assets/pdfplomo.png',
                                  width: 200,
                                  height: 100,
                                ),
                                const SizedBox(height: 5),
                                ButtonWidget(
                                  text: 'Abrir',
                                  icon: Icons.open_in_new,
                                  onClicked: () async {
                                    final url = 'files/_plan de practicas_MUNI_C.pdf';
                                    final file = await PDFApi.loadFirebase(url);

                                    if (file == null) return;
                                    openPDF(context, file);
                                  },
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                            margin: const EdgeInsets.only(
                                left: 10.0, top: 10.0, bottom: 3.0, right: 3.0),
                            padding: const EdgeInsets.only(
                                left: 12.0,
                                top: 10.0,
                                bottom: 10.0,
                                right: 12.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(255, 61, 61, 61),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(5),
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Color.fromARGB(255, 244, 250, 255),
                                    Color.fromARGB(255, 184, 184, 184),
                                  ],
                                )),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'CONSTANCIA DE EVALUACIÓN',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                Image.asset(
                                  'assets/pdfplomo.png',
                                  width: 200,
                                  height: 100,
                                ),
                                const SizedBox(height: 5),
                                ButtonWidget(
                                  text: 'Abrir',
                                  icon: Icons.open_in_new,
                                  onClicked: () async {
                                    final url = 'files/ficha evaluacion.pdf';
                                    final file = await PDFApi.loadFirebase(url);

                                    if (file == null) return;
                                    openPDF(context, file);
                                  },
                                ),
                              ],
                            )),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)),
      );
}
