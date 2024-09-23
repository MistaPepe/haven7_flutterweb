import 'package:flutter/material.dart';
import 'package:haven7_flutterweb/ui/component_widgets/components.dart';

import '../../provider/provider.dart';

class DesktopLayout extends StatefulWidget {
  const DesktopLayout({super.key});

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {
  @override
  Widget build(BuildContext context) {
    var menuButton = IconButton(
      icon: isDrawerOpen ? Icon(Icons.close) : Icon(Icons.menu),
      onPressed: () {
        setState(() {
          isDrawerOpen = !isDrawerOpen;
        });
      },
    );

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 248, 255),
      body: Center(
        child: Row(
          children: [
            Stack(children: [
                      CustomDrawerDesktop(),
                      Positioned(
            top: 5,
            left: 10,
            child: menuButton),
                    ]),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
   
              ],
            ),
          ),
        ),
                
          ],
        ),
      ),
    );
  }
}

class CustomDrawerDesktop extends DrawerRouterList {
  const CustomDrawerDesktop({super.key});

  @override
  Widget container(List<Widget> routerList) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: isDrawerOpen ? 250 : 80,
      height: double.infinity,
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 60, 5, 0),
        child: ListView(
          children: routerList,
        ),
      ),
    );
  }
}
