import 'package:flutter/material.dart';
import 'package:haven7_flutterweb/provider/general.dart';
import 'package:haven7_flutterweb/ui/component_widgets/components.dart';

class MediumLayout extends StatefulWidget {
  const MediumLayout({super.key});

  @override
  State<MediumLayout> createState() => _MediumLayoutState();
}

class _MediumLayoutState extends State<MediumLayout> {
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
        setState(() {
          DrawerRouter.isDrawerOpen = !DrawerRouter.isDrawerOpen;
        });
      },
    );
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 41, 158),
      body: Center(
        child: Row(
          children: [
            //Drawer Widget
            // ignore: prefer_const_constructors
            CustomDrawerMediumAndDesktop(),

            //Body Widget
            Expanded(
              child: Container(
                margin:const EdgeInsets.fromLTRB(0, 15, 0, 5),
                decoration: const BoxDecoration(
                    color:  Color.fromARGB(255, 255, 249, 243),
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
                      Row(
                        children: [
                          menuButton,
                          //appbar widget
                        ],
                      ),
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
    return const CardStatisticsWrapper();
  }
}
