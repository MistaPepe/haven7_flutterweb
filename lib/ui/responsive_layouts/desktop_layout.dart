import 'package:flutter/material.dart';
import '../../provider/provider.dart';
import '../component_widgets/components_and_routers.dart';

class DesktopLayout extends StatefulWidget {
  const DesktopLayout({super.key});

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {
  
  Widget tabControl() {
    if (DrawerRouter.currentPage == 'Dashboard') {
      return const DashboardLayout();
    } else {
      return const Placeholder();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 41, 158),
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
        child: Row(
          children: [
            //Drawer Widget, tho it is in constant open state, so i guess it just a router not a drawer

            const CustomAnimatedDrawer(),

            //Body Widget
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 15, 10, 5),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(221, 229, 249, 255),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      topLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //appbar or top body
                      const CustomAppBarButtons(hasMenuButton: false),

                      Expanded(
                        child: tabControl(),
                      )
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
