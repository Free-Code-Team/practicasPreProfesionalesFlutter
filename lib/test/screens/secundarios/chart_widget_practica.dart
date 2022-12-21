import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:practicas_pre_profesionales_flutter/test/data/practica_chart.dart';

class PracChartWidget extends StatelessWidget {
  final List<Practica> practicas;

  const PracChartWidget(this.practicas, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 2.0,
        child: PieChart(PieChartData(
          sectionsSpace: 2.0,
          sections: _chartSections(practicas),
          centerSpaceRadius: 50.0,
        )));
  }

  List<PieChartSectionData> _chartSections(List<Practica> practicas) {
    final List<PieChartSectionData> list = [];
    for (var practica in practicas) {
      const double radius = 40.0;
      final data = PieChartSectionData(
        color: practica.color,
        value: practica.value,
        radius: radius,
        title: '',
      );
      list.add(data);
    }
    return list;
  }
}
