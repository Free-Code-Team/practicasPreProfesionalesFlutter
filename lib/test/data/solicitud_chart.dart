import 'dart:math';

import 'package:flutter/material.dart';

class Solicitud {
  final Color color;
  final double value;
  final String title;

  Solicitud({required this.color, required this.value, required this.title});
}


List<double> get randomNumbers {
  final Random random = Random();
  final randomNumbers = <double>[];
  for (var i = 1; i <= 7; i++) {
    randomNumbers.add(random.nextDouble() * 100);
  }

  return randomNumbers;
}

List<Solicitud> get estadoSolicitudes {
  return [
    Solicitud(
        color: Color.fromARGB(255, 142, 9, 160),
        value: randomNumbers[0],
        title: 'Solicitues Aceptadas'),
    Solicitud(
        color: Color.fromARGB(255, 10, 6, 56),
        value: randomNumbers[1],
        title: 'Solicitudes Rechazadas'),
    Solicitud(
        color: Color.fromARGB(255, 21, 192, 169),
        value: randomNumbers[2],
        title: 'Solicitudes por validar'),
  ];
}