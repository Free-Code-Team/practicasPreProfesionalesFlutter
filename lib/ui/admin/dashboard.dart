import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/bloc/auth/auth_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/test/data/practica_chart.dart';
import 'package:practicas_pre_profesionales_flutter/test/data/price_point.dart';
import 'package:practicas_pre_profesionales_flutter/test/data/solicitud_chart.dart';
import 'package:practicas_pre_profesionales_flutter/test/screens/secundarios/chart_widget_practica.dart';
import 'package:practicas_pre_profesionales_flutter/test/screens/secundarios/chart_widget_solicitud.dart';
import 'package:practicas_pre_profesionales_flutter/test/screens/secundarios/line_chart_widget.dart';
import 'package:practicas_pre_profesionales_flutter/ui/admin/drawer_admin.dart';
import 'package:flutter/material.dart';
import 'package:practicas_pre_profesionales_flutter/ui/auth/sign_in.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Random random = Random();

    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is DesautenticadoState) {
            // Navigate to the sign in screen when the user Signs Out
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const SignIn()),
              (route) => false,
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Dashboard'),
            centerTitle: true,
            backgroundColor: Colors.blue[900],
          ),
          drawer: const DrawerAdmin(),
          bottomNavigationBar: BottomAppBar(
            color: Colors.blue[900],
            child: Row(
              children: [
                IconButton(
                    icon: const Icon(Icons.account_circle),
                    color: Colors.white,
                    onPressed: () {}),
                const Spacer(),
                IconButton(
                    icon: const Icon(Icons.logout),
                    color: Colors.white,
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context)
                          .add(DesautenticarEvent());
                    }),
              ],
            ),
          ),
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
          )
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