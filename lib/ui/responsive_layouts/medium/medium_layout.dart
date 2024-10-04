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
              CustomDrawerMediumAndDesktop(),
              Positioned(top: 5, left: 10, child: menuButton),
            ]),

            //Body Widget
             Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///first column, the main body for medium size broweser
                    ///consist of cards, graph, and clients
                    const Text(
                      'Welcome to Haven 7!',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Montserrat',
                        color:  Color.fromARGB(255, 0, 99, 145),
                        letterSpacing:
                            1.2, 
                      ),
                    ),
                   const SizedBox(height: 20),
                    CardTemplate(baseWidth: 200, baseHeight: 75, child: Container()),
                    const SizedBox(height: 20),
                    const CardTemplate(
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
