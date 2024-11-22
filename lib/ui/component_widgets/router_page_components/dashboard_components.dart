import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components.dart';

class DashboarLayout extends StatefulWidget {
  const DashboarLayout({super.key});

  @override
  State<DashboarLayout> createState() => _DashboarLayoutState();
}

class _DashboarLayoutState extends State<DashboarLayout> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height, // 60% of screen height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        clipBehavior: Clip.antiAlias, // Ensures clipping is active
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
                        Expanded(
                            flex: 2,
                            child: UrgentCostumerOrder(
                              customerList: listOfCustomerurgent,
                            ))
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const GraphOverallSales(),
                        const SizedBox(
                          height: 20,
                        ),
                        UrgentCostumerOrder(
                          customerList: listOfCustomerurgent,
                        )
                      ],
                    );
            }),
            const SizedBox(
              height: 20,
            ),
            Center(child: TodayOverallPieChart())
          ],
        ));
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
                style: const TextStyle(
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
                  style: const TextStyle(
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
                      style: const TextStyle(
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
        haveShadow: false,
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

/// Graph of overall sales- by days, months etc..

class GraphOverallSales extends StatefulWidget {
  const GraphOverallSales({super.key});

  @override
  State<GraphOverallSales> createState() => _GraphOverallSalesState();
}

class _GraphOverallSalesState extends State<GraphOverallSales> {
  // Initial selected value
  static String selectedValue = '7 Days';

  // List of options
  static List<String> dropdownOptions = [
    '7 Days',
    '15 Days',
    '30 days',
    '3 Months',
    '6 Months',
    'Year',
    'Overall'
  ];

  @override
  Widget build(BuildContext context) {
    var optionButton = DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        icon: const Icon(
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
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            selectedValue = newValue!;
          });
        },
        dropdownColor: Colors.blueGrey.shade700, // Background color of dropdown
        style: const TextStyle(
            color: Colors.black), // Color for selected item text
        borderRadius: BorderRadius.circular(12), // Rounded corners for dropdown
        menuMaxHeight: 225, // Limit the max height if there are many options
      ),
    );

    return CardTemplateSimple(
      baseHeight: 430,
      baseWidth: 400,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 50, top: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sales for $selectedValue',
                    style: GoogleFonts.lato(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Colors.black12.withOpacity(0.8)),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 15, top: 10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: optionButton,
                  ),
                ),
              ),
            ],
          ),
          const Expanded(
              child: Padding(
            padding: EdgeInsets.all(20),
            child: LineGraphAverage(),
          )),
        ],
      ),
    );
  }
}

class TodayOverallPieChart extends StatefulWidget {
  const TodayOverallPieChart({super.key});

  @override
  State<TodayOverallPieChart> createState() => _TodayOverallPieChartState();
}

class _TodayOverallPieChartState extends State<TodayOverallPieChart> {
  String selectedButton = 'Go back to Sales';

  static Map<String, List<Color>> subcategoryColors = {
    "Expenses": const [
      Color(0xFFFFC1C1),
      Color(0xFFFF8A80),
      Color(0xFFFF5252),
      Color(0xFFD32F2F)
    ],
    "Profit": const [Color(0xFFBBDEFB), Color(0xFF64B5F6), Color(0xFF0D47A1)],
    "Debt": const [Color(0xFFC8E6C9), Color(0xFF43A047), Color(0xFF1B5E20)],
  };
  // Define categories and their subsets
  final Map<String, List<String>> categoryData = {
    "Expenses": ["Food", "Gas", "Production", "Employee Salary"],
    "Profit": ["Pet Bottles", "Gallon", "Slim"],
    "Debt": ["Unpaid Bills", "Loan", "Pending Salaries"],
  };

  @override
  Widget build(BuildContext context) {
    final Map<String, double> mainData = {
      'Expenses': 20,
      'Profit': 70,
      'Debt': 10
    };

    var expenseIndicates = GraphIndicator()
      ..title = (selectedButton == "Profit") ? "" : mainData.keys.first
      ..color = (selectedButton == "Profit") ? null : Colors.redAccent
      ..subCategories =
          (selectedButton == "Expenses") ? categoryData.values.first : []
      ..build(context);

    var profitIndicates = GraphIndicator()
      ..title = (selectedButton == "Expenses") ? "" : mainData.keys.last
      ..color = (selectedButton == "Expenses") ? null : Colors.pink
      ..subCategories = (selectedButton == "Profit")
          ? categoryData.entries
              .firstWhere((entry) => entry.key == mainData.keys.last)
              .value
          : []
      ..build(context);

    buttons(String name) {
      return Flexible(
          child: CustomCallbackButton(
        paddingHeight: 10,
        paddingWidth: 20,
        text: name,
        onPressed: () {
          setState(() {
            selectedButton = name;
          });
        },
      ));
    }

    final indicatesButtons = ListView(shrinkWrap: true, children: [
      expenseIndicates,
      profitIndicates,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buttons((selectedButton != mainData.keys.first)
              ? mainData.keys.first
              : 'Go back to Sales'),
          buttons((selectedButton != mainData.keys.last)
              ? mainData.keys.last
              : 'Go back to Sales'),
        ],
      )
    ]);

    return LayoutBuilder(builder: (context, constraint) {
      return CardTemplateSimple(
        padding: 30,
        baseWidth: 1000,
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              children: [
                Flexible(
                  child: SizedBox(
                      height: 300, child: InteractivePieChart(data: mainData)),
                ),
                const SizedBox(
                  width: 15,
                ),
                if (constraint.maxWidth > 600)
                  Flexible(child: indicatesButtons),
              ],
            ),
            if (constraint.maxWidth < 601) indicatesButtons
          ],
        ),
      );
    });
  }
}

///-------------------------------------------------------------------------------

///-------------------------------------------------------------------------------
//generate a list of list of int for random ARGB color for the container of icons

class UrgentCostumerOrder extends StatefulWidget {
  final List<CustomerUrgentDetails>? customerList;
  const UrgentCostumerOrder({super.key, this.customerList});

  @override
  State<UrgentCostumerOrder> createState() => _UrgentCostumerOrderState();
}

class _UrgentCostumerOrderState extends State<UrgentCostumerOrder> {
  bool _isHovering = false;
  int _indexHover = -1;

  static List<List<int>> colorList = List.generate(5, (index) {
    List<int> placeholder = [];
    for (int i = 0; i < 4; i++) {
      var firstIndex = (i == 0) ? 200 : 75;
      placeholder.add(Random().nextInt(255 - firstIndex) + firstIndex);
    }

    return placeholder;
  });

  List<CustomerUrgentDetails> get _getCustomerList =>
      (widget.customerList?.isEmpty ?? true)
          ? [
              const CustomerUrgentDetails(
                "No urgent order, Everything is in ORDER HE!",
                Icon(Icons.person),
                1,
              ),
            ]
          : widget.customerList!;

//builder for each row of order, - icons, name and the arrow button build here
  Widget layoutList() {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 20,
        );
      },
      itemCount: min(_getCustomerList.length, 5),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        List<int> argbList = colorList[index];

        double itemScale = 1 + (20 / MediaQuery.of(context).size.width);
        return MouseRegion(
          onEnter: (_) => setState(() {
            _isHovering = true;
            _indexHover = index;
          }),
          onExit: (_) => setState(() {
            _isHovering = false;
            _indexHover = -1;
          }),
          child: GestureDetector(
            onTap: () {
              print(index); // add function
            },
            child: Transform.scale(
              scale: (_isHovering && index == _indexHover) ? itemScale : 1.0,
              child: Row(
                children: [
                  CardTemplateSimple(
                      baseHeight: 40,
                      baseWidth: 40,
                      color: Color.fromARGB(
                          argbList[0], argbList[1], argbList[2], argbList[3]),
                      child: _getCustomerList[index].icon),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Text(
                    _getCustomerList[index].name,
                    style: const TextStyle(fontSize: 16),
                  )),
                  SizedBox.square(
                    dimension: 40,
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.chevron_right)),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget containerBuilder(Widget child) {
    return CardTemplateBox(
        shouldEnlarge: false,
        useBackgroundStack: true,
        baseHeight: 430,
        baseWidth: 400,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Colors.white.withOpacity(0.5),
                ]),
          ),
          padding: const EdgeInsets.only(top: 10, left: 10, bottom: 20),
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                'Pending Order',
                style: GoogleFonts.lato(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.black12.withOpacity(0.8)),
              ),
              Expanded(child: child),
              (_getCustomerList.length > 5)
                  ? Center(
                      child: TextButton(
                          onPressed: () {}, child: Text('More on Customer')),
                    )
                  : SizedBox()
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.customerList!.isEmpty) {
      return containerBuilder(Align(
        alignment: Alignment.center,
        child: Text(
          _getCustomerList[0].name,
          style: GoogleFonts.lato(
              fontSize: 25,
              fontWeight: FontWeight.w600,
              color: Colors.black12.withOpacity(0.8)),
        ),
      ));
    } else {
      return containerBuilder(layoutList());
    }
  }
}

var customer1 = const CustomerUrgentDetails('Justin', Icon(Icons.person), 1);
var customer5 = const CustomerUrgentDetails('butu', Icon(Icons.person), 1);
var customer6 = const CustomerUrgentDetails('Justin', Icon(Icons.person), 1);
var customer2 = const CustomerUrgentDetails('Justin', Icon(Icons.person), 1);
var customer3 = const CustomerUrgentDetails('Justin', Icon(Icons.person), 1);

List<CustomerUrgentDetails> listOfCustomerurgent = [
  customer1,
  customer5,
  customer5,
  customer2,
  customer3,
  customer5,
  customer6,
];

class CustomerUrgentDetails {
  final String name;
  final Widget icon;
  final int time;
  const CustomerUrgentDetails(this.name, this.icon, this.time);
}

///-------------------------------------------------------------------------------
///
///-----------------------------------------------------------------------------

class CampaignBanner extends StatelessWidget {
  const CampaignBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
