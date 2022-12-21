import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:practicas_pre_profesionales_flutter/test/data/price_point.dart';

const _dashArray = [4, 2];

class LineChartWidget extends StatelessWidget {
  final List<CantidadSolicitud> points;
  final bool isPositiveChange;

  const LineChartWidget(this.points, this.isPositiveChange, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final minY = points.map((point) => point.y).reduce(min);
    final maxY = points.map((point) => point.y).reduce(max);

    return AspectRatio(
      aspectRatio: 2,
      child: LineChart(
        LineChartData(
            lineTouchData: LineTouchData(
                enabled: true,
                touchCallback:
                    (FlTouchEvent event, LineTouchResponse? touchResponse) {
                },
                touchTooltipData: LineTouchTooltipData(
                  tooltipBgColor: Colors.blue,
                  tooltipRoundedRadius: 20.0,
                  showOnTopOfTheChartBoxArea: true,
                  fitInsideHorizontally: true,
                  tooltipMargin: 0,
                  getTooltipItems: (touchedSpots) {
                    return touchedSpots.map(
                      (LineBarSpot touchedSpot) {
                        const textStyle = TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        );
                        return LineTooltipItem(
                          points[touchedSpot.spotIndex].y.toInt().toString(),
                          textStyle,
                        );
                      },
                    ).toList();
                  },
                ),
                getTouchedSpotIndicator:
                    (LineChartBarData barData, List<int> indicators) {
                  return indicators.map(
                    (int index) {
                      final line = FlLine(
                          color: Colors.grey,
                          strokeWidth: 1,
                          dashArray: _dashArray);
                      return TouchedSpotIndicatorData(
                        line,
                        FlDotData(show: false),
                      );
                    },
                  ).toList();
                },
                getTouchLineEnd: (_, __) => double.infinity),
            lineBarsData: [
              LineChartBarData(
                spots: points.map((point) => FlSpot(point.x, point.y)).toList(),
                isCurved: false,
                colors: [
                  isPositiveChange ? Color.fromARGB(255, 32, 1, 53) : Color.fromARGB(255, 13, 140, 156),
                ],
                dotData: FlDotData(
                  show: false,
                ),
              ),
            ],
            minY: minY,
            minX: 0,
            maxY: maxY,
            borderData: FlBorderData(
                border: const Border(bottom: BorderSide(), left: BorderSide())),
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(
              bottomTitles: _bottomTitles,
              leftTitles: SideTitles(showTitles: false),
              topTitles: SideTitles(showTitles: false),
              rightTitles: SideTitles(showTitles: false),
            )),
      ),
    );
  }
}

SideTitles get _bottomTitles => SideTitles(
      showTitles: true,
      reservedSize: 22,
      margin: 10,
      interval: 1,
      getTextStyles: (context, value) => const TextStyle(
        color: Colors.blueGrey,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      getTitles: (value) {
        switch (value.toInt()) {
          case 1:
            return 'ENE';
          case 3:
            return 'FEB';
          case 5:
            return 'MAR';
          case 7:
            return 'ABR';
          case 9:
            return 'MAY';
          // case 11:
          //   return 'JUN';
        }
        return '';
      },
    );
