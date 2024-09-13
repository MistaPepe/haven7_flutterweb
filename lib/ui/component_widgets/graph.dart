import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyPieChart extends StatelessWidget {
  final List<PieChartSectionData> 
 pieChartData;

  const MyPieChart({required this.pieChartData});

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: pieChartData,
        centerSpaceRadius: 70,
        startDegreeOffset: 180,
        sectionsSpace: 0,
        centerSpaceColor: Colors.transparent,
        pieTouchData: PieTouchData(

        ),
      ),
    );
  }
}