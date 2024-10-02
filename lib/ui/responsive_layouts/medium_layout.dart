import 'package:flutter/material.dart';
import 'package:haven7_flutterweb/provider/general.dart';
import 'package:haven7_flutterweb/ui/component_widgets/components.dart';

class MediumLayout extends StatefulWidget {
  const MediumLayout({super.key});

  @override
  State<MediumLayout> createState() => _MediumLayoutState();
}

class _MediumLayoutState extends State<MediumLayout> {
  @override
  Widget build(BuildContext context) {
    var menuButton = IconButton(
      icon: DrawerRouter.isDrawerOpen
          ? const Icon(
              Icons.close,
              color: Colors.white,
            )
          : const Icon(
              Icons.menu,
              color: Colors.white,
            ),
      onPressed: () {
        setState(() {
          DrawerRouter.isDrawerOpen = !DrawerRouter.isDrawerOpen;
        });
      },
    );
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 249, 243),
      body: Center(
        child: Row(
          children: [
            //Drawer Widget
            Stack(children: [
              CustomDrawerMedium(),
              Positioned(top: 5, left: 10, child: menuButton),
            ]),

            //Body Widget
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///first column, the main body for medium size broweser
                    ///consist of cards, graph, and clients
                    Text(
                      'Welcome to Haven 7!',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Montserrat',
                        color: Colors.blue, 
                        letterSpacing:
                            1.2, 
                      ),
                    ),
                    SizedBox(height: 20),
                    CardTemplate(
                      baseHeight: 300,
                      baseWidth: 700,
                      child: LineChartSample2(),
                    ),
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

class CustomDrawerMedium extends DrawerRouterList {
  const CustomDrawerMedium({super.key});

  @override
  Widget container(List<Widget> routerList) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: DrawerRouter.isDrawerOpen ? 250 : 75,
      height: double.infinity,
      color: const Color.fromARGB(255, 0, 98, 143),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 60, 5, 0),
        child: ListView(
          children: routerList,
        ),
      ),
    );
  }
}
