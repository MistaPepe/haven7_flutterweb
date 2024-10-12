import 'package:flutter/material.dart';
import '../../provider/provider.dart';
import '../component_widgets/components.dart';

class DesktopLayout extends StatefulWidget {
  const DesktopLayout({super.key});

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}


class _DesktopLayoutState extends State<DesktopLayout> {
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

              CustomDrawerMediumAndDesktop(),

            //Body Widget
             Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      children: [
                        ///first column, the main body for medium size broweser
                        ///consist of cards, graph, and clients
      
                       const SizedBox(height: 20),
                        
                        CardTemplate(baseWidth: 200, baseHeight: 75, child: Container()),
                        CardTemplate(baseWidth: 200, baseHeight: 75, child: Container()),
                        CardTemplate(baseWidth: 200, baseHeight: 75, child: Container()),
                        CardTemplate(baseWidth: 200, baseHeight: 75, child: Container()),
                        const SizedBox(height: 20),
                        const CardTemplate(
                          baseHeight: 300,
                          baseWidth: 700,
                          child: LineChartSample2(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }}