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
            TodayOverallPieChart()
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

class TodayOverallPieChart extends StatelessWidget {
  TodayOverallPieChart({super.key});

  // Define categories and their subsets
  final Map<String, List<String>> categoryData = {
    "Expenses": ["Food", "Gas", "Production", "Employee Salary"],
    "Profit": ["Pet Bottles", "Gallon", "Slim"],
    "Debt": ["Unpaid Bills", "Loan", "Pending Salaries"],
  };

  // Define colors for main categories and subcategories
  static const List<Color> mainColors = [
    Colors.blueAccent, // Profit
    Colors.redAccent, // Debt
    Colors.orangeAccent, // Expenses
  ];

  static Map<String, List<Color>> subcategoryColors = {
    "Expenses": [Colors.green, Colors.orange, Colors.purple, Colors.teal],
    "Profit": [Colors.blue[400]!, Colors.blue[200]!, Colors.blue[100]!],
    "Debt": [Colors.red[400]!, Colors.red[300]!, Colors.red[200]!],
  };

  @override
  Widget build(BuildContext context) {
    return CardTemplateSimple(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Pie Chart Section
          SizedBox(
            height: 450,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child:
                        InteractivePieChart(), // Replace with your pie chart widget
                  ),
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: categoryData.entries
                        .map((entry) => _buildCategory(entry))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Builds a category indicator with subcategories
  Widget _buildCategory(MapEntry<String, List<String>> entry) {
    final int categoryIndex = categoryData.keys.toList().indexOf(entry.key);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main Category Indicator
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Indicator(
            color: mainColors[categoryIndex],
            text: entry.key,
            isSquare: true,
          ),
        ),
        // Subcategories
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: List.generate(
            entry.value.length,
            (subIndex) => Indicator(
              color: subcategoryColors[entry.key]![subIndex],
              text: entry.value[subIndex],
              isSquare: true,
            ),
          ),
        ),
        const SizedBox(height: 16), // Spacing between categories
      ],
    );
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
