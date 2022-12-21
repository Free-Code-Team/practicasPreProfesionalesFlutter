import 'dart:math';
import 'package:collection/collection.dart';

class CantidadSolicitud {
  final double x;
  final double y;

  CantidadSolicitud({required this.x, required this.y});
}

List<CantidadSolicitud> get cantidadSolicitud {
  final Random random = Random();
  final randomNumbers = <double>[];
  for (var i = 1; i <= 12; i++) {
    randomNumbers.add(random.nextDouble());
  }

  return randomNumbers
      .mapIndexed(
          (index, element) => CantidadSolicitud(x: index.toDouble(), y: element))
      .toList();
}
