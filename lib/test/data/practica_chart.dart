import 'dart:math';

import 'package:flutter/material.dart';

class Practica {
  final Color color;
  final double value;
  final String title;

  Practica({required this.color, required this.value, required this.title});
}


List<double> get randomNumbers {
  final Random random = Random();
  final randomNumbers = <double>[];
  for (var i = 1; i <= 7; i++) {
    randomNumbers.add(random.nextDouble() * 100);
  }

  return randomNumbers;
}

List<Practica> get estadoPracticas {
  return [
    Practica(
        color: Color.fromARGB(255, 206, 23, 99),
        value: randomNumbers[0],
        title: 'Practicas completadas'),
    Practica(
        color: Color.fromARGB(255, 29, 66, 167),
        value: randomNumbers[1],
        title: 'Practicas en proceso'),
    Practica(
        color: Color.fromARGB(255, 25, 250, 220),
        value: randomNumbers[2],
        title: 'Practicas canceladas'),
  ];
}