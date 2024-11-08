import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = contentColorCyan;
  static const Color menuBackground = Color(0xFF090912);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color mainGridLineColor = Colors.white10;
  static const Color borderColor = Colors.white54;
  static const Color gridLinesColor = Color(0x11FFFFFF);

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);
}

//line graph with goal in red line, or average
class LineGraphAverage extends StatefulWidget {
  const LineGraphAverage({super.key});

  @override
  State<LineGraphAverage> createState() => _LineGraphAverageState();
}

class _LineGraphAverageState extends State<LineGraphAverage> {
  var spots = List.generate(
    30,
    (index) {
      return FlSpot(index.toDouble(), 1000 + (index * 20));
    },
  );

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (touchedSpot) => const Color.fromARGB(255, 28, 41, 158),
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((touchedSpot) {
                // Access the value and add custom content
                final value = touchedSpot.y;
                final index = touchedSpot.spotIndex;

                // Customize the tooltip content here
                return LineTooltipItem(
                  'Index: $index\nValue: $value\nAdditional info here',
                  TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }).toList();
            },
          ),
        ),
        maxY: 4000,
        minY: 0,
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          drawVerticalLine: false,
          horizontalInterval: 500, // Draws grid lines at every 500 units
          getDrawingHorizontalLine: (value) {
            if (value == 2000) {
              // Draw a thicker line at 2000
              return const FlLine(color: Colors.red, strokeWidth: 2);
            }
            return const FlLine(color: Colors.transparent);
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1, // Show title for each day
              getTitlesWidget: (value, meta) {
                return Text(
                  'Day ${value.toInt() + 1}',
                  style: const TextStyle(color: Colors.black, fontSize: 10),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              minIncluded: false,
              reservedSize: 50,
              showTitles: true,
              interval: 1000, // Show title for every 500 units on the left
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.toInt()}',
                  style: const TextStyle(color: Colors.black, fontSize: 15),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: Colors.green,
            barWidth: 3,
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  Colors.green.withOpacity(0.5),
                  Colors.green.withOpacity(0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            dotData: const FlDotData(show: true),
          ),
        ],
      ),
    );
  }
}

///line chart only
class Linechart1 extends StatelessWidget {
  const Linechart1({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        maxY: 4000,
        minY: 0,
        gridData: FlGridData(
          show: false,
          getDrawingHorizontalLine: (value) {
            if (value == 2000) {
              // Draw a thicker line at 2000
              return FlLine(color: Colors.red, strokeWidth: 2);
            }
            return FlLine(color: Colors.grey.withOpacity(0.2), strokeWidth: 1);
          },
        ),
        titlesData: FlTitlesData(
          show: false,
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 1000),
              FlSpot(3, 2100),
              FlSpot(4, 2300),
              FlSpot(5, 4300),
              FlSpot(6, 5300),
            ],
            isCurved: true,
            color: Colors.green,
            barWidth: 3,
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  Colors.green.withOpacity(0.3),
                  Colors.green.withOpacity(0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            dotData: FlDotData(show: false),
          ),
        ],
      ),
    );
  }
}

//bar chart
class SalesBarChart extends StatelessWidget {
  const SalesBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 20,
          minY: 0,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  'Sales: ${rod.toY.round()}',
                  TextStyle(color: Colors.white),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text('${value.toInt() * 1000}',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold));
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const months = [
                    'Jan',
                    'Feb',
                    'Mar',
                    'Apr',
                    'May',
                    'Jun',
                    'Jul',
                    'Aug',
                    'Sep',
                    'Oct',
                    'Nov',
                    'Dec'
                  ];
                  return Text(
                    months[value.toInt()],
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(
            show: false,
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 5,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey.shade300,
                strokeWidth: 1,
              );
            },
          ),
          barGroups: _getBarGroups(),
        ),
      ),
    );
  }

  List<BarChartGroupData> _getBarGroups() {
    final data = [5, 12, 8, 10, 14, 7, 13, 17, 15, 12, 8, 10];
    return data.asMap().entries.map((entry) {
      int idx = entry.key;
      double value = entry.value.toDouble();
      return BarChartGroupData(
        x: idx,
        barRods: [
          BarChartRodData(
            toY: value,
            width: 18,
            borderRadius: BorderRadius.circular(6),
            gradient: LinearGradient(
              colors: [
                Colors.blueAccent,
                Colors.blueAccent.shade100,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ],
      );
    }).toList();
  }
}

/// piechart
class InteractivePieChart extends StatefulWidget {
  final Map<String, double>? slices;
  const InteractivePieChart({super.key, this.slices});

  @override
  State<InteractivePieChart> createState() => _InteractivePieChartState();
}

class _InteractivePieChartState extends State<InteractivePieChart> {
  int _selectedIndex = -1;

  // Define data for each section
  final List<double> _sectionValues = [
    40,
    30,
    20,
    10
  ]; // Adjust values as needed

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(builder: (context, constriant) {
        return PieChart(
          PieChartData(
            sections: _getSections(),
            centerSpaceRadius:
                (constriant.maxWidth / 8 < 50) ? constriant.maxWidth / 8 : 50,
            sectionsSpace: 2,
            pieTouchData: PieTouchData(
              touchCallback: (event, pieTouchResponse) {
                setState(() {
                  if (!event.isInterestedForInteractions ||
                      pieTouchResponse == null ||
                      pieTouchResponse.touchedSection == null) {
                    _selectedIndex = -1;
                    return;
                  }
                  _selectedIndex =
                      pieTouchResponse.touchedSection!.touchedSectionIndex;
                });
              },
            ),
          ),
        );
      }),
    );
  }

  List<PieChartSectionData> _getSections() {
    final total = _sectionValues
        .reduce((a, b) => a + b); // Calculate total to get percentage

    return List.generate(_sectionValues.length, (index) {
      final isSelected = index == _selectedIndex;
      final double radius =
          isSelected ? 60 : 50; // Enlarge radius when selected
      final double fontSize = isSelected ? 18 : 14;
      final color =
          [Colors.blue, Colors.green, Colors.orange, Colors.red][index];
      final percentage =
          (_sectionValues[index] / total * 100).toStringAsFixed(1);

      return PieChartSectionData(
        value: _sectionValues[index],
        color: color,
        title: (_sectionValues[index] / total * 100 > 9) ? '$percentage%' : "",
        titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white),
        radius: radius,
      );
    });
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}
