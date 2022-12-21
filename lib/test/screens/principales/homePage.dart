
import 'package:flutter/material.dart';
import 'package:practicas_pre_profesionales_flutter/test/comp/customAppBar.dart';
import 'package:practicas_pre_profesionales_flutter/test/comp/customDrawer.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget{
  const HomePage ({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: CustomAppBar(),
        drawer: CustomDrawer(),
        body: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 5, left: 15, right: 15),
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(255, 6, 9, 12),
                  Color.fromARGB(255, 28, 53, 121),
                ],
              )
              ),
              child: Column(
                children: <Widget>[

                  // Usamos ListTile para ordenar la información del card como titulo, subtitulo e icono
                  ListTile(
                    contentPadding: EdgeInsets.fromLTRB(15, 5, 25, 0),
                    title: Center(
                      child: Text('Requisitos', style: TextStyle(fontStyle: FontStyle.italic, color: Color.fromARGB(255, 0, 225, 255).withOpacity(1), fontSize: 20)),),
                    subtitle: Text(
                      textAlign: TextAlign.justify,
                        '* Foto personal actual con las siguentes caracteristicas......... \n* Constancia de aprobación de cursos de 5to ciclo..........\n* Estar entre el ciclo VI y el X ..........', style: TextStyle(fontStyle: FontStyle.italic, color: Color.fromARGB(255, 255, 255, 255).withOpacity(1))),
                    leading: Container(
                      constraints: const BoxConstraints(minWidth: 70.0, maxWidth: 80),
                      height: double.infinity,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset('assets/requisitos.gif'),
                      )
                    ),
                    
                  ),
                  
                  const SizedBox(height: 5),
                  // Usamos una fila para ordenar los botones del card
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,// background// foreground
                        ),
                        onPressed: _launchURLBrowser, child: Text('Información completa', style: TextStyle(fontStyle: FontStyle.italic, color: Color.fromARGB(255, 43, 233, 247).withOpacity(1)))),
                    ],
                  )
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(255, 6, 9, 12),
                  Color.fromARGB(255, 28, 53, 121),
                ],
              )
              ),
              child: Column(
                children: <Widget>[

                  // Usamos ListTile para ordenar la información del card como titulo, subtitulo e icono
                  ListTile(
                    contentPadding: EdgeInsets.fromLTRB(15, 5, 25, 0),
                    title: Center(
                      child: Text('Procedimientos', style: TextStyle(fontStyle: FontStyle.italic, color: Color.fromARGB(255, 0, 225, 255).withOpacity(1), fontSize: 20)),),
                    
                    subtitle: Text(
                      textAlign: TextAlign.justify,
                        '* Ingresa a pppUPeU > Trámite.\n* En “Solicitudes”, haz clic en “Solicitud de carta de presentación para prácticas o empleo”.\n* Al llegar a la nueva plataforma, haz clic en “Iniciar trámite”.\n* Selecciona el tipo de carta que necesitas y rellena todos los campos.\n* Llena todos los campos indicados.', style: TextStyle(fontStyle: FontStyle.italic, color: Color.fromARGB(255, 255, 255, 255).withOpacity(1))),
                    leading: Container(
                      constraints: const BoxConstraints(minWidth: 70.0, maxWidth: 80),
                      height: double.infinity,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset('assets/procedimientos.gif'),
                      )
                    ),
                    
                  ),
                  
                  const SizedBox(height: 5),
                  // Usamos una fila para ordenar los botones del card
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                        ),
                        onPressed: _launchURLBrowser, child: Text('Información completa', style: TextStyle(fontStyle: FontStyle.italic, color: Color.fromARGB(255, 43, 233, 247).withOpacity(1)))),
                    ],
                  )
                ],
              ),
        ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(255, 6, 9, 12),
                  Color.fromARGB(255, 28, 53, 121),
                ],
              )
              ),
              child: Column(
                children: <Widget>[

                  // Usamos ListTile para ordenar la información del card como titulo, subtitulo e icono
                  ListTile(
                    contentPadding: EdgeInsets.fromLTRB(15, 5, 25, 0),
                    title: Center(
                      child: Text('Derechos', style: TextStyle(fontStyle: FontStyle.italic, color: Color.fromARGB(255, 0, 225, 255).withOpacity(1), fontSize: 20)),),
                    subtitle: Text(
                      textAlign: TextAlign.justify,
                        'Los practicantes pre profesionales tienen derecho a una jornada no mayor de 36 horas a la semana o seis horas diarias. A media subvención por cada 6 meses de servicios.', style: TextStyle(fontStyle: FontStyle.italic, color: Color.fromARGB(255, 255, 255, 255).withOpacity(1))),
                    leading: Container(
                      constraints: const BoxConstraints(minWidth: 70.0, maxWidth: 80),
                      height: double.infinity,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset('assets/check_list.gif'),
                      )
                    ),
                    
                  ),
                  
                  const SizedBox(height: 5),
                  // Usamos una fila para ordenar los botones del card
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                        ),
                        onPressed: _launchURLBrowser, child: Text('Información completa', style: TextStyle(fontStyle: FontStyle.italic, color: Color.fromARGB(255, 43, 233, 247).withOpacity(1)))),
                    ],
                  )
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(255, 6, 9, 12),
                  Color.fromARGB(255, 28, 53, 121),
                ],
              )
              ),
              child: Column(
                children: <Widget>[

                  // Usamos ListTile para ordenar la información del card como titulo, subtitulo e icono
                  ListTile(
                    contentPadding: EdgeInsets.fromLTRB(15, 5, 25, 0),
                    title: Center(
                      child: Text('Responsabilidades', style: TextStyle(fontStyle: FontStyle.italic, color: Color.fromARGB(255, 0, 225, 255).withOpacity(1), fontSize: 20)),),
                    
                    subtitle: Text(
                      textAlign: TextAlign.justify,
                        'Asistir puntualmente a su Centro de Práctica y, de no ser posible, informar con anticipación a su supervisor inmediato. Observar las reglas de seguridad en el trabajo. Realizar las tareas que le sean asignadas con eficiencia y responsabilidad.', style: TextStyle(fontStyle: FontStyle.italic, color: Color.fromARGB(255, 255, 255, 255).withOpacity(1))),

                    leading: Container(
                      constraints: const BoxConstraints(minWidth: 70.0, maxWidth: 80),
                      height: double.infinity,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset('assets/responsabilidades.gif'),
                      )
                    ),
                    
                    
                  ),
                  
                  const SizedBox(height: 5),
                  // Usamos una fila para ordenar los botones del card
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,// background// foreground
                        ),
                        onPressed: _launchURLBrowser, child: Text('Información completa', style: TextStyle(fontStyle: FontStyle.italic, color: Color.fromARGB(255, 43, 233, 247).withOpacity(1)))),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 15, left: 15, right: 15),
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(255, 6, 9, 12),
                  Color.fromARGB(255, 28, 53, 121),
                ],
              )
              ),
              child: Column(
                children: <Widget>[

                  // Usamos ListTile para ordenar la información del card como titulo, subtitulo e icono
                  ListTile(
                    contentPadding: EdgeInsets.fromLTRB(15, 5, 25, 0),
                    title: Center(
                      child: Text('Otros', style: TextStyle(fontStyle: FontStyle.italic, color: Color.fromARGB(255, 0, 225, 255).withOpacity(1), fontSize: 20)),),
                    
                    subtitle: Text(
                      textAlign: TextAlign.justify,
                        '¿En que consiste? Tiene como finalidad fomentar....\n¿Donde se realiza? Secretaria de la Universidad Peruna Unión......\n¿Aquien va dirigido? la carta de solicitud debe de ir dirigido a una persona especifica....\n¿Cuanto cuesta?', style: TextStyle(fontStyle: FontStyle.italic, color: Color.fromARGB(255, 255, 255, 255).withOpacity(1))),
                    leading: ConstrainedBox(
                      constraints: BoxConstraints(
                      ),
                      child: Image.asset('assets/otros.gif', fit: BoxFit.cover),
                    ),
                    
                  ),
                  
                  const SizedBox(height: 5),
                  // Usamos una fila para ordenar los botones del card
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,// background// foreground
                        ),
                        onPressed: _launchURLBrowser, child: Text('Información completa', style: TextStyle(fontStyle: FontStyle.italic, color: Color.fromARGB(255, 43, 233, 247).withOpacity(1)))),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
            ),
          ),
        ),
      ),
      
    );
  }
}


_launchURLBrowser() async {
  var url = Uri.parse("https://upeu.edu.pe/");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}