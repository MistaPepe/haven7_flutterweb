import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../components.dart';

class DashboarLayout extends StatefulWidget {
  const DashboarLayout({super.key});

  @override
  State<DashboarLayout> createState() => _DashboarLayoutState();
}

class _DashboarLayoutState extends State<DashboarLayout> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        shrinkWrap: true,
        children: [
          const CardStatisticsWrapper(),
          const SizedBox(
            height: 20,
          ),
          LayoutBuilder(builder: (context, constraint) {
            return (constraint.maxWidth > 1000)
                ? Row(
                    children: [
                      const Expanded(flex: 5, child: GraphOverallSales()),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(flex: 2, child: TodayOverallPieChart())
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GraphOverallSales(),
                      const SizedBox(
                        height: 20,
                      ),
                      TodayOverallPieChart()
                    ],
                  );
          }),
          const SizedBox(
            height: 20,
          ),
          Flexible(child: UrgentCostumerOrder()),
        ],
      ),
    );
  }
}

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
                color: Colors.blue[800],
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
              width: 20,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 141, 255, 145),
                      Color.fromARGB(255, 216, 255, 107),
                      Color.fromARGB(255, 141, 255, 145)
                    ]),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5))),
                height: 7,
              ),
            ),
            const SizedBox(
              width: 20,
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

  static Widget template(
      IconData icon, String title, int numbers, int percentage) {
    return CardTemplateBox(
        haveShadow: true,
        isCurved: true,
        baseHeight: _baseHeight,
        baseWidth: _baseWidth,
        child: UpperCardTemplate(
          icon: icon,
          title: title,
          numbers: numbers,
          percentage: percentage,
        ));
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
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                (constraint.maxWidth > 1000) ? 4 : 2, // Number of columns
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            mainAxisExtent: 150, // Fixed height for each grid item
          ),
          itemCount: 4, // Number of items
          itemBuilder: (context, index) {
            return _cardContent[index];
          },
          shrinkWrap: true,
        );
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
  // Initial selected value
  static String selectedValue = 'Option 1';

  // List of options
  static List<String> dropdownOptions = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4'
  ];

  @override
  Widget build(BuildContext context) {
    var optionButton = DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        icon: Icon(
          size: 30,
          Icons.more_vert,
          color: Colors.black,
        ),
        value: selectedValue,
        items: dropdownOptions.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            selectedValue = newValue!;
          });
        },
        dropdownColor: Colors.blueGrey.shade700, // Background color of dropdown
        style: TextStyle(color: Colors.black), // Color for selected item text
        borderRadius: BorderRadius.circular(12), // Rounded corners for dropdown
        menuMaxHeight: 200, // Limit the max height if there are many options
      ),
    );

    return CardTemplateSimple(
      baseHeight: 400,
      baseWidth: 400,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(right: 15, top: 5),
            height: 40,
            child: Align(
              alignment: Alignment.centerRight,
              child: optionButton,
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(20),
            child: const LineGraphAverage(),
          )),
        ],
      ),
    );
  }
}

class TodayOverallPieChart extends StatelessWidget {
  TodayOverallPieChart({super.key});

  static List<Color> colorIndicator = [
    Colors.green,
    Colors.orangeAccent,
    Colors.redAccent,
    Colors.blueAccent,
  ];

  final _indicates = List.generate(4, (index) {
    return SizedBox(
        width: 100,
        child: Indicator(
            color: colorIndicator[index], text: 'butu', isSquare: true));
  });

  @override
  Widget build(BuildContext context) {
    return CardTemplateBox(
        useBackgroundStack: true,
        baseHeight: 400,
        baseWidth: 400,
        child: Column(children: [
          Flexible(child: const InteractivePieChart()),
          ..._indicates
        ]));
  }
}

class UrgentCostumerOrder extends StatelessWidget {
  final List<CustomerUrgentDetails>? customerList;
  const UrgentCostumerOrder({super.key, this.customerList});

  List<CustomerUrgentDetails> get _getCustomerList =>
      customerList ??
      [
        const CustomerUrgentDetails(
            "No urgent order, Everything is in ORDER HE!",
            Icons.emoji_people,
            1)
      ];

  Widget layoutList() {
    return ListView.builder(
      padding: EdgeInsets.all(20),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Row(
          children: [
            SizedBox.square(
              dimension: 40,
              child: Icon(_getCustomerList[index].icon),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(child: Text(_getCustomerList[index].name)),
            SizedBox.square(
              dimension: 40,
              child:
                  IconButton(onPressed: () {}, icon: Icon(Icons.chevron_right)),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CardTemplateSimple(
        baseHeight: 400, baseWidth: 400, child: layoutList());
  }
}

class CustomerUrgentDetails {
  final String name;
  final IconData icon;
  final int time;
  const CustomerUrgentDetails(this.name, this.icon, this.time);
}
