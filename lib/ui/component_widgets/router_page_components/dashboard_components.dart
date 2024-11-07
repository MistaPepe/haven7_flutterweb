import 'package:flutter/material.dart';

import '../components.dart';

//template for card widget showing earnings and more
class UpperCardTemplate extends StatelessWidget {
  final int numbers;
  final String title;
  final IconData icon;
  final int percentage;

  const UpperCardTemplate({
    super.key,
    required this.numbers,
    required this.title,
    required this.icon,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(
                icon,
                size: 40,
                color: Colors.blue,
              ),

              // Title below the icon
              Text(
                title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        // Number below the title
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 8,
                child: Text(
                  '$numbers',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
              ),
              // Percentage at the bottom or graph
              Flexible(
                flex: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '+ $percentage%',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),

        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5))),
                height: 7,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        )
      ],
    );
  }
}

// upper card statistics, widgets to show average info
class CardStatisticsWrapper extends StatelessWidget {
  const CardStatisticsWrapper({super.key});

  static const int _baseWidth = 280;
  static const int _baseHeight = 150;

  static Expanded template(
      IconData icon, String title, int numbers, int percentage) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: CardTemplateBox(
            haveShadow: true,
            isCurved: true,
            baseHeight: _baseHeight,
            baseWidth: _baseWidth,
            child: UpperCardTemplate(
              icon: icon,
              title: title,
              numbers: numbers,
              percentage: percentage,
            )),
      ),
    );
  }

  static final List<Widget> _cardContent = [
    template(Icons.monetization_on, 'Today\'s earning', 3000, 11),
    template(Icons.bar_chart, 'Monthly Earnings', 3000, 11),
    template(
      Icons.shopping_cart,
      'Total Orders',
      3000,
      11,
    ),
    template(
      Icons.money_off,
      'Expenses',
      3000,
      11,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      buildWrap() {
        if (constraint.maxWidth > 1070) {
          return Row(
            children: _cardContent,
          );
        } else {
          return SizedBox(
            child: Column(
              children: [
                Row(
                  children: [_cardContent[0], _cardContent[1]],
                ),
                Row(
                  children: [_cardContent[2], _cardContent[3]],
                )
              ],
            ),
          );
        }
      }

      return buildWrap();
    });
  }
}

/// Graph of overall sales

class GraphOverallSales extends StatefulWidget {
  const GraphOverallSales({super.key});

  @override
  State<GraphOverallSales> createState() => _GraphOverallSalesState();
}

class _GraphOverallSalesState extends State<GraphOverallSales> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: CardTemplateSimple(
          baseHeight: 400,
          baseWidth: 400,
          child: LineGraphAverage()))
      ],
    );
  }
}
