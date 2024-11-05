import 'package:flutter/material.dart';
import 'package:haven7_flutterweb/provider/general.dart';
import 'package:haven7_flutterweb/ui/component_widgets/components.dart';

class MediumLayout extends StatefulWidget {
  const MediumLayout({super.key});

  @override
  State<MediumLayout> createState() => _MediumLayoutState();
}

class _MediumLayoutState extends State<MediumLayout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget tabControl() {
    if (DrawerRouter.currentPage == 'Dashboard') {
      return const DashboardMedium();
    } else {
      return const Placeholder();
    }
  }

  @override
  Widget build(BuildContext context) {
    var menuButton = IconButton(
      icon: DrawerRouter.isDrawerOpen
          ? const Icon(
              Icons.close,
              color: Colors.black,
            )
          : const Icon(
              Icons.menu,
              color: Colors.black,
            ),
      onPressed: () {
        //butu
        setState(() {
          (MediaQuery.of(context).size.width < 950) ? 
          _scaffoldKey.currentState?.openDrawer() : 
          DrawerRouter.isDrawerOpen = !DrawerRouter.isDrawerOpen;
        });
      },
    );

    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomConcealingDrawer(),

      body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 28, 41, 158),
                  Color.fromARGB(255, 0, 49, 212),
                  Color.fromARGB(255, 26, 74, 233),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
              ),
            ),
        child: Center(
          child: Row(
            children: [
              //Drawer Widget
              // ignore: prefer_const_constructors
              CustomAnimatedDrawer(),
        
              //Body Widget
              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 15, 0, 5),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(237, 255, 255, 255),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //appbar or top body
                        // Row(
                        //   children: [
                        //     menuButton,
                        //     //appbar widget
                        //   ],
                        // ),
                        menuButton,
                        const SizedBox(height: 20),
                        tabControl()
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardMedium extends StatefulWidget {
  const DashboardMedium({super.key});

  @override
  State<DashboardMedium> createState() => _DashboardMediumState();
}

class _DashboardMediumState extends State<DashboardMedium> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          const CardStatisticsWrapper(),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: Offset(0, 3), // Changes the shadow position
                ),
              ],
            ),
            child:LineChartSample2())
        ],
      ),
    );
  }
}
