import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../provider/provider.dart';
import '../components_and_routers.dart';

class DashboardLayout extends StatefulWidget {
  const DashboardLayout({super.key});

  @override
  State<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout> {
  bool isMouseInAWidget = false;

  double _sharedHeight = 0;

  void _updateSharedHeight(BuildContext context) {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final newHeight = renderBox.size.height;
      if (_sharedHeight != newHeight) {
        setState(() {
          _sharedHeight = newHeight;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var schedWidget = MouseRegion(
      onEnter: (_) => setState(() {
        isMouseInAWidget = true;
      }),
      onExit: (_) => setState(() {
        isMouseInAWidget = false;
      }),
      child: const TodayActivityWidget(
        title: "Thursday Task",
      ),
    );

    return ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: Container(
            margin: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height, // 60% of screen height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            clipBehavior: Clip.antiAlias,
            child: ListView(
              physics: (isMouseInAWidget)
                  ? const NeverScrollableScrollPhysics()
                  : const BouncingScrollPhysics(),
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
                                child: PendingCustomerOrder(
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
                            PendingCustomerOrder(
                              customerList: listOfCustomerurgent,
                            )
                          ],
                        );
                }),
                const SizedBox(
                  height: 20,
                ),
                LayoutBuilder(builder: (context, constraint) {
                  if (constraint.maxWidth > 800) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 3,
                          child: SizedBox(
                              height: _sharedHeight, child: schedWidget),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 5,
                          child: LayoutBuilder(
                            builder: (context, _) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                _updateSharedHeight(context);
                              });
                              return const TodayOverallPieChart();
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          width: 400,
                          height: 430,
                          child: TodayActivityWidget(
                            title: "Thursday Task",
                          ),
                        ),
                        SizedBox(height: 20),
                        TodayOverallPieChart(),
                      ],
                    );
                  }
                })
              ],
            )));
  }
}

//template for card widget showing earnings and more
class UpperCardTemplate extends StatelessWidget {
  final int numbers;
  final String title;
  final IconData icon;
  final int percentage;
  final bool isPositive;

  const UpperCardTemplate({
    super.key,
    required this.numbers,
    required this.title,
    required this.icon,
    required this.percentage,
    required this.isPositive,
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
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
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
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '$numbers',
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              // Percentage at the bottom or graph
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '+ $percentage%',
                      style: TextStyle(
                        fontSize: 16,
                        color: (isPositive) ? Colors.green : Colors.red,
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
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: (isPositive)
                            ? const [
                                Color.fromARGB(255, 141, 255, 145),
                                Color.fromARGB(255, 216, 255, 107),
                                Color.fromARGB(255, 141, 255, 145)
                              ]
                            : const [
                                Color.fromARGB(255, 255, 141, 141),
                                Color.fromARGB(255, 255, 160, 35),
                                Color.fromARGB(255, 255, 141, 141)
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

  static Widget template(IconData icon, String title, int numbers,
      int percentage, bool isPositive) {
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
          isPositive: isPositive,
        ));
  }

  static final List<Widget> _cardContent = [
    template(Icons.monetization_on, 'Today\'s earning', 3000, 11, true),
    template(Icons.bar_chart, 'Monthly Earnings', 34000, 30, true),
    template(Icons.shopping_cart, 'Total Orders', 120, 5, true),
    template(Icons.money_off, 'Expenses', 15000, 11, false),
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

List<FlSpot> spots = List.generate(400, (index) {
      double currentValue = 2000;
      // Generate a random fluctuation within a larger range
      double fluctuation = Random().nextDouble() * 1000 -
          500; // Random value between -500 and +500
      currentValue += fluctuation;

      // Ensure the value stays within the range of 1500 to 3000
      currentValue = currentValue.clamp(1500, 3000);
      currentValue += fluctuation; // Add fluctuation to the current value
      return FlSpot(index.toDouble(), currentValue);
    });

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

  daysSelected(String value) {
    switch (value) {
      case '7 Days':
        return 7;
      case '15 Days':
        return 15;
      case '30 days':
        return 30;
      case '3 Months':
        return 90;
      case '6 Months':
        return 180;
      case 'Year':
        return 365;
      default:
        return 400;
    }
  }


  @override
  Widget build(BuildContext context) {

    List<FlSpot> returnSpots = [];
    for(int i = 0; i < daysSelected(selectedValue); i++){
      returnSpots.add(spots[i]);
    }

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
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(20),
            child: LineGraphAverage(
              spots: returnSpots,
            ),
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

String selectedButton = 'Go back';
int showExpenseCheckBox = 1;

class _TodayOverallPieChartState extends State<TodayOverallPieChart> {
//color for piechart and graph indicator for main and each subcategory
  static Map<String, List<Color>> categoryColor = {
    'Go back': const [
      Colors.lightBlue,
      Colors.green,
      Colors.redAccent,
    ],
    "Cash Sales": const [
      Color.fromARGB(255, 0, 140, 255),
      Color.fromARGB(255, 125, 194, 250),
      Color(0xFF0D47A1)
    ],
    "Due": const [Color(0xFF43A047), Color(0xFF1B5E20)],
    "Expenses": const [
      Color.fromARGB(255, 255, 0, 0),
      Color(0xFFFF8A80),
      Color.fromARGB(255, 133, 14, 14),
      Color.fromARGB(255, 211, 47, 102)
    ],
  };
  // data for subset and their value-------------------
  final Map<String, List<String>> subCategoryName = {
    "Cash Sales": ["Pet Bottles", "Gallon", "Slim"],
    "Due": ["Unpaid Bills", "Loan"],
    "Expenses": ["Food & Gas", "Electricity", "Production", "Employee Salary"],
  };

  final Map<String, List<double>> subCategoryNumber = {
    "Cash Sales": [2980, 1580, 1660],
    "Due": [2980, 400],
    "Expenses": [200, 400, 1490, 1200],
  };
  //-----------------------------

  //method to return a map of names of subcategory then eihter a double or color as value
  Map<String, T> subcategoryData<T>(List<String> names, List<T> values) {
    Map<String, T> placeholder = {};
    for (int i = 0; i < names.length; i++) {
      placeholder[names[i]] = values[i];
    }
    return placeholder;
  }

  Icon _getIcon() {
    switch (showExpenseCheckBox) {
      case 1:
        return const Icon(Icons.check_box_rounded, color: Colors.white);
      case 2:
        return const Icon(Icons.check_box_outline_blank_rounded,
            color: Colors.white);
      default:
        return const Icon(Icons.pie_chart, color: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, double> mainDataNoExpense = {
      'Cash Sales': subCategoryNumber.entries
          .firstWhere((entry) => entry.key == 'Cash Sales')
          .value
          .reduce((a, b) => a + b)
          .toDouble(),
      'Due': subCategoryNumber.entries
          .firstWhere((entry) => entry.key == 'Due')
          .value
          .reduce((a, b) => a + b)
          .toDouble(),
    };

    ///data for pie chart when there are no selected slice
    ///this is the data will shown first in the piechart
    Map<String, double> mainData = {
      ...mainDataNoExpense, //since they have similar contents apart from expense
      'Expenses': -subCategoryNumber.entries
          .firstWhere((entry) => entry.key == 'Expenses')
          .value
          .reduce((a, b) => a + b)
          .toDouble(),
    };

    buttons(String name) => CustomCallbackButton(
          paddingHeight: 10,
          paddingWidth: 20,
          text: name,
          icon: (name == "Expenses") ? _getIcon() : null,
          onPressed: () {
            setState(() {
              if (name == "Expenses" && showExpenseCheckBox == 1) {
                showExpenseCheckBox++;
                selectedButton = 'Go back';
              } else if (name == "Expenses" && showExpenseCheckBox == 2) {
                showExpenseCheckBox++;
                selectedButton = name;
              } else if (name == "Expenses" && showExpenseCheckBox == 3) {
                showExpenseCheckBox = 1;
                selectedButton = 'Go back';
              } else {
                showExpenseCheckBox = 1;
                selectedButton = name;
              }
            });
          },
        );

    ///graph indicator for each categories
    ///it also rewrites the sub category when the user inputs or change the selected button

    final cashSalesIndicates = GraphIndicator()
      ..title = "Cash Sales"
      ..color = Colors.lightBlue
      ..mapSubCategory = (selectedButton == 'Cash Sales')
          ? subcategoryData(
              subCategoryName.entries
                  .firstWhere((entry) => entry.key == selectedButton)
                  .value,
              categoryColor.entries
                  .firstWhere((entry) => entry.key == selectedButton)
                  .value)
          : {}
      ..subNum = (selectedButton == 'Cash Sales')
          ? subCategoryNumber.entries
              .firstWhere((entry) => entry.key == selectedButton)
              .value
          : [];

    final dueindicates = GraphIndicator()
      ..title = "Dues"
      ..color = const Color.fromARGB(255, 30, 233, 98)
      ..mapSubCategory = (selectedButton == 'Due')
          ? subcategoryData(
              subCategoryName.entries
                  .firstWhere((entry) => entry.key == selectedButton)
                  .value,
              categoryColor.entries
                  .firstWhere((entry) => entry.key == selectedButton)
                  .value)
          : {}
      ..subNum = (selectedButton == 'Due')
          ? subCategoryNumber.entries
              .firstWhere((entry) => entry.key == selectedButton)
              .value
          : [];

    final expenseIndicates = GraphIndicator()
      ..title = "Expenses"
      ..color = Colors.redAccent
      ..mapSubCategory = (selectedButton == "Expenses")
          ? subcategoryData(
              subCategoryName.entries
                  .firstWhere((entry) => entry.key == selectedButton)
                  .value,
              categoryColor.entries
                  .firstWhere((entry) => entry.key == selectedButton)
                  .value)
          : {}
      ..subNum = (selectedButton == "Expenses")
          ? subCategoryNumber.entries
              .firstWhere((entry) => entry.key == selectedButton)
              .value
          : [];
//--------------------------------------------

//the section wherein the graph indicates colors and buttons are presented
    final indicatesButtons = Column(children: [
      if (selectedButton != "Expenses" && selectedButton != "Due")
        cashSalesIndicates,
      if (selectedButton != "Expenses" && selectedButton != "Cash Sales")
        dueindicates,
      if (selectedButton != "Cash Sales" &&
          selectedButton != "Due" &&
          showExpenseCheckBox != 2)
        expenseIndicates,
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            buttons((selectedButton != mainData.keys.first)
                ? 'Cash Sales'
                : 'Go back'),
            buttons((selectedButton != "Due") ? "Due" : 'Go back'),
            buttons((mainData.keys.last)),
          ],
        ),
      )
    ]);
//---------------------------------------------

// this is where the return layout for the whole class
    return LayoutBuilder(builder: (context, constraint) {
      pieChartSelec() {
        if (showExpenseCheckBox == 2) {
          return mainDataNoExpense;
        } else if (selectedButton == 'Go back') {
          return mainData;
        } else {
          return subcategoryData(subCategoryName[selectedButton]!,
              subCategoryNumber[selectedButton]!);
        }
      }

      return CardTemplateSimple(
        padding: 30,
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: 300,
                    width: 300,
                    child: InteractivePieChart(
                      data: pieChartSelec(),
                      listColor: categoryColor.entries
                          .firstWhere((entry) => entry.key == selectedButton)
                          .value,
                    )),
                const SizedBox(
                  width: 15,
                ),
                if (constraint.maxWidth > 740) // indicates and buttons section
                  Expanded(
                      child: SizedBox(height: 300, child: indicatesButtons)),
              ],
            ),
            if (constraint.maxWidth <
                741) // indicates and buttons section if width is too small
              SizedBox(height: 250, child: indicatesButtons)
          ],
        ),
      );
    });
  }
}

///-------------------------------------------------------------------------------

///-------------------------------------------------------------------------------
//generate a list of list of int for random ARGB color for the container of icons

class PendingCustomerOrder extends StatefulWidget {
  final List<CustomerUrgentDetails>? customerList;
  const PendingCustomerOrder({super.key, this.customerList});

  @override
  State<PendingCustomerOrder> createState() => _PendingCustomerOrderState();
}

class _PendingCustomerOrderState extends State<PendingCustomerOrder> {
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

///-------------------------------------------------------------------------------
///
///-----------------------------------------------------------------------------

class TodayActivityWidget extends StatefulWidget {
  final String title;

  const TodayActivityWidget({required this.title, super.key});

  @override
  State<TodayActivityWidget> createState() => _TodayActivityWidgetState();
}

class _TodayActivityWidgetState extends State<TodayActivityWidget> {
  @override
  Widget build(BuildContext context) {
    return CardTemplateSimple(
        baseHeight: 400,
        child: SfCalendar(
          view: CalendarView.workWeek, // Use week view for more detailed events
          firstDayOfWeek: 1, // Start the week on Monday
          todayHighlightColor:
              Colors.orange, // Highlight today's date in orange
          selectionDecoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.3), // Highlight selected date
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5),
          ),
          headerStyle: const CalendarHeaderStyle(
            textAlign: TextAlign.center,
            backgroundColor: Color.fromARGB(255, 58, 87, 183),
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          viewHeaderStyle: ViewHeaderStyle(
            backgroundColor: Colors.purple.shade100,
            dayTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            dateTextStyle: const TextStyle(
              color: Colors.black54,
              fontSize: 12,
            ),
          ),
          dataSource: EventDataSource(_getDataSource()),
          timeSlotViewSettings: const TimeSlotViewSettings(
            startHour: 7, // Display events starting from 8 AM
            endHour: 18, // Ending at 8 PM
            timeFormat: 'h:mm a', // AM/PM format for times
            timeIntervalHeight: 60,
            timeTextStyle: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          appointmentTextStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
            showAgenda: true, // Show agenda at the bottom in month view
            agendaStyle: AgendaStyle(
              backgroundColor: Colors.purple,
              appointmentTextStyle: TextStyle(color: Colors.white),
            ),
          ),
          showNavigationArrow:
              true, // Add navigation arrows for better usability
        ));
  }

  List<Appointment> _getDataSource() {
    final List<Appointment> meetings = <Appointment>[];

    // Example of events
    meetings.add(Appointment(
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 1)),
      subject: 'Meeting',
      color: Colors.blue,
    ));

    meetings.add(Appointment(
      startTime: DateTime.now().add(const Duration(days: 2, hours: 3)),
      endTime: DateTime.now().add(const Duration(days: 2, hours: 4)),
      subject: 'Conference',
      color: Colors.red,
    ));

    meetings.add(Appointment(
      startTime: DateTime.now().add(const Duration(days: 5)),
      endTime: DateTime.now().add(const Duration(days: 5, hours: 2)),
      subject: 'Workshop',
      color: Colors.green,
    ));

    return meetings;
  }
}

/// Custom data source class for events
class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Appointment> appointments) {
    this.appointments = appointments;
  }
}
