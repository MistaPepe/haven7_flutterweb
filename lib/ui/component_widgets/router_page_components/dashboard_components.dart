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
        clipBehavior: Clip.antiAlias,
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
            const Center(child: TodayOverallPieChart()),
            const Center(child: TodayActivityWidget(title: "Thursday Task",))
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
        baseWidth: 800,
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

//example for customer
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
class TodayActivityWidget extends StatefulWidget {
  final String title;

  const TodayActivityWidget({required this.title, Key? key}) : super(key: key);

  @override
  State<TodayActivityWidget> createState() => _TodayActivityWidgetState();
}

class _TodayActivityWidgetState extends State<TodayActivityWidget> {
  Map<String, List<String>> weeklyTasks = {
    "Monday": ["Task 1", "Task 2"],
    "Tuesday": ["Task 3", "Task 4"],
    "Wednesday": ["Task 5"],
    "Thursday": ["Task 6", "Task 7"],
    "Friday": ["Task 8"],
  };

  void _showWeeklyPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  "Weekly Schedule",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: weeklyTasks.keys.length,
                    itemBuilder: (context, index) {
                      final day = weeklyTasks.keys.elementAt(index);
                      final tasks = weeklyTasks[day]!;
                      return ExpansionTile(
                        title: Text(
                          day,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        children: [
                          ReorderableListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            onReorder: (oldIndex, newIndex) {
                              setState(() {
                                if (newIndex > oldIndex) {
                                  newIndex -= 1;
                                }
                                final task = tasks.removeAt(oldIndex);
                                tasks.insert(newIndex, task);
                              });
                            },
                            children: tasks
                                .map(
                                  (task) => Dismissible(
                                    key: ValueKey(task),
                                    direction: DismissDirection.endToStart,
                                    background: Container(
                                      alignment: Alignment.centerRight,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      color: Colors.red,
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onDismissed: (direction) {
                                      setState(() {
                                        tasks.remove(task);
                                      });
                                    },
                                    child: ListTile(
                                      key: ValueKey(task),
                                      title: Text(task),
                                      trailing: const Icon(Icons.drag_handle),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          TextButton.icon(
                            onPressed: () => _addTaskForDay(context, day),
                            icon: const Icon(Icons.add),
                            label: const Text("Add Task"),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _addTaskForDay(BuildContext context, String day) {
    TextEditingController taskController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text("Add Task for $day"),
          content: TextField(
            controller: taskController,
            decoration: const InputDecoration(hintText: "Enter task name"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  weeklyTasks[day]!.add(taskController.text);
                });
                Navigator.of(dialogContext).pop(); // Close the dialog
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final todayTasks = weeklyTasks[widget.title.split(" ")[0]] ?? [];
    return CardTemplateSimple(
      baseHeight: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title and options
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  _showWeeklyPopup(context);
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Draggable list of today's tasks
          Expanded(
            child: ReorderableListView(
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) {
                    newIndex -= 1;
                  }
                  final task = todayTasks.removeAt(oldIndex);
                  todayTasks.insert(newIndex, task);
                });
              },
              children: todayTasks
                  .map(
                    (task) => Dismissible(
                      key: ValueKey(task),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        color: Colors.red,
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (direction) {
                        setState(() {
                          todayTasks.remove(task);
                        });
                      },
                      child: ListTile(
                        key: ValueKey(task),
                        title: Text(task),
                        trailing: const Icon(Icons.drag_handle),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}