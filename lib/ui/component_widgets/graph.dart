
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


//line graph with goal in red line, or average
class LineGraphAverage extends StatefulWidget {
  final List<FlSpot> spots;
  const LineGraphAverage({super.key, required this.spots});

  @override
  State<LineGraphAverage> createState() => _LineGraphAverageState();
}

class _LineGraphAverageState extends State<LineGraphAverage> {
 

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (touchedSpot) =>
                const Color.fromARGB(255, 28, 41, 158),
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((touchedSpot) {
                // Access the value and add custom content
                final value = touchedSpot.y;
                final index = touchedSpot.spotIndex;

                // Customize the tooltip content here
                return LineTooltipItem(
                  'Index: $index\nValue: $value\nAdditional info here',
                  const TextStyle(
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
              // sideTitles: SideTitles(
              //   showTitles: true,
              //   interval: 1, // Show title for each day
              //   getTitlesWidget: (value, meta) {
              //     return Text(
              //       'Day ${value.toInt() + 1}',
              //       style: const TextStyle(color: Colors.black, fontSize: 10),
              //     );
              //   },
              // ),
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
            spots: widget.spots,
            isCurved: true,
            color: Colors.blueAccent,
            barWidth: 3,
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 28, 240, 255).withOpacity(0.8),
                  const Color.fromARGB(255, 67, 186, 255).withOpacity(0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            dotData: const FlDotData(
              show: false,
            ),
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
        titlesData: const FlTitlesData(
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
            spots: const [
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
            dotData: const FlDotData(show: false),
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
                  const TextStyle(color: Colors.white),
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
                      style: const TextStyle(
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
                    style: const TextStyle(
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
  final Map<String, double> data;
  final List<Color> listColor;
  final String? title;

  const InteractivePieChart(
      {super.key, required this.data, required this.listColor, this.title});

  @override
  State<InteractivePieChart> createState() => _InteractivePieChartState();
}

class _InteractivePieChartState extends State<InteractivePieChart> {
  int _hoveredIndex = -1; // Track the hovered slice index

  // Generate pie chart sections dynamically
  List<PieChartSectionData> _getSections(Map<String, double> data) {
    return List.generate(data.length, (index) {
      final listOfColor = widget.listColor;
      final isHovered = index == _hoveredIndex;
      final double radius = isHovered ? 60 : 50;
      final double fontSize = isHovered ? 18 : 14;

      return PieChartSectionData(
        color: listOfColor[index],
        value: (data.keys.elementAt(index) != "Expenses")
            ? data.values.elementAt(index)
            : -data.values.elementAt(index),
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        radius: radius,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final chartData = widget.data;
    final total = chartData.values.reduce((a, b) => a + b);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Pie Chart
        SizedBox(
          height: 250,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PieChart(
                PieChartData(
                  sections: _getSections(chartData),
                  centerSpaceRadius: 50,
                  sectionsSpace: 2,
                  pieTouchData: PieTouchData(
                    touchCallback: (event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          _hoveredIndex = -1;
                          return;
                        }
                        _hoveredIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),

        // Hovered Slice Info
        if (_hoveredIndex != -1)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              '${chartData.keys.elementAt(_hoveredIndex)}: ${chartData.values.elementAt(_hoveredIndex)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Total Profit: $total',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
      ],
    );
  }
}

class GraphIndicator extends StatefulWidget {
  Color color = Colors.white;
  String title = 'butu';
  bool isSquare = true;
  Color textColor = Colors.black;
  Map<String, Color> mapSubCategory = {};
  double size = 16;
  List<double> subNum = [];

  @override
  State<GraphIndicator> createState() => _GraphIndicatorState();
}

class _GraphIndicatorState extends State<GraphIndicator> {
//main generator for each row or tile
  Widget indicateTile(String text, {Color? subColor, double? num}) {
    return SizedBox(
      height: 35,
      child: Row(
        children: <Widget>[
          if (subColor != null) // spacer like an intend
            const SizedBox(
              width: 30,
            ),
          Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: widget.isSquare ? BoxShape.rectangle : BoxShape.circle,
              color: subColor ?? widget.color,
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: widget.textColor,
            ),
          ),
          if (subColor != null) // spacer like an intend
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  num.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: widget.textColor,
                  ),
                ),
              ),
            ),
          if (subColor != null) // spacer like an intend
            const SizedBox(
              width: 30,
            ),
        ],
      ),
    );
  }

//generate when there is sub
  withSub() {
    int index = -1;
    var numList = widget.subNum;
    return Column(
        children: widget.mapSubCategory.entries.map((entry) {
      index++;
      return indicateTile(entry.key,
          subColor: entry.value, num: numList[index]);
    }).toList());
  }

  buildIndicates() {
    return (widget.mapSubCategory.isEmpty)
        ? indicateTile(widget.title)
        : Column(
            children: [indicateTile(widget.title), withSub()],
          );
  }

  @override
  Widget build(BuildContext context) {
    return buildIndicates();
  }
}
