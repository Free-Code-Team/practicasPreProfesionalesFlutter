import 'dart:math';

import 'package:flutter/material.dart';
import 'package:practicas_pre_profesionales_flutter/test/comp/customAppBar.dart';
import 'package:practicas_pre_profesionales_flutter/test/data/practica_chart.dart';
import 'package:practicas_pre_profesionales_flutter/test/data/solicitud_chart.dart';

import 'package:practicas_pre_profesionales_flutter/test/data/price_point.dart';
import 'package:practicas_pre_profesionales_flutter/test/screens/secundarios/chart_widget_solicitud.dart';
import 'package:practicas_pre_profesionales_flutter/test/screens/secundarios/chart_widget_practica.dart';
import 'package:practicas_pre_profesionales_flutter/test/screens/secundarios/line_chart_widget.dart';

class ChartPage extends StatefulWidget {
  const ChartPage ({Key? key}) : super(key: key);

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  final Random random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 15),

                // PRACTICA
                Text(
                  'GRAFICO DE PRACTICAS',
                  style: TextStyle(
                      color: Color.fromARGB(255, 8, 17, 56),
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                  textAlign: TextAlign.center,),
                const SizedBox(height: 15),
                Column(
                  children: estadoPracticas
                      .map<Widget>((practica) => PracticaRow(practica))
                      .toList(),
                ),
                PracChartWidget(estadoPracticas),
                

                //SOLICITUDES LINE
                const SizedBox(height: 60),
                Text(
                  'PRACTICAS DURANTE UN SEMESTRE',
                  style: TextStyle(
                      color: Color.fromARGB(255, 8, 17, 56),
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                  textAlign: TextAlign.center,),
                const SizedBox(height: 15),
                LineChartWidget(cantidadSolicitud, random.nextBool()),

                //ESTADO SOLICITUDES
                const SizedBox(height: 60),
                Text(
                  'ESTADO DE SOLICITUDES',
                  style: TextStyle(
                      color: Color.fromARGB(255, 8, 17, 56),
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                  textAlign: TextAlign.center,),
                const SizedBox(height: 15),
                SoliChartWidget(estadoSolicitudes),
                Column(
                  children: estadoSolicitudes
                      .map<Widget>((solicitud) => SolicitudRow(solicitud))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SolicitudRow extends StatelessWidget {
  const SolicitudRow(this.solicitud, {Key? key}) : super(key: key);
  final Solicitud solicitud;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 16,
          child: CircleAvatar(
            backgroundColor: solicitud.color,
          ),
        ),
        const Spacer(),
        Text(solicitud.title, style: TextStyle(color: Color.fromARGB(255, 8, 17, 56),
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  textAlign: TextAlign.center,),
      ],
    );
  }
}


class PracticaRow extends StatelessWidget {
  const PracticaRow(this.practica, {Key? key}) : super(key: key);
  final Practica practica;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 16,
          child: CircleAvatar(
            backgroundColor: practica.color,
          ),
        ),
        const Spacer(),
        Text(practica.title, style: TextStyle(color: Color.fromARGB(255, 8, 17, 56),
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  textAlign: TextAlign.center,),
      ],
    );
  }
}