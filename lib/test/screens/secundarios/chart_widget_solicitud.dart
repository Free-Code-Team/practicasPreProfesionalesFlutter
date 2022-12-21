import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:practicas_pre_profesionales_flutter/test/data/solicitud_chart.dart';

class SoliChartWidget extends StatelessWidget {
  final List<Solicitud> solicitudes;

  const SoliChartWidget(this.solicitudes, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 2.0,
        child: PieChart(PieChartData(
          sectionsSpace: 2.0,
          sections: _chartSections(solicitudes),
          centerSpaceRadius: 50.0,
        )));
  }

  List<PieChartSectionData> _chartSections(List<Solicitud> solicitudes) {
    final List<PieChartSectionData> list = [];
    for (var solicitud in solicitudes) {
      const double radius = 40.0;
      final data = PieChartSectionData(
        color: solicitud.color,
        value: solicitud.value,
        radius: radius,
        title: '',
      );
      list.add(data);
    }
    return list;
  }
}
