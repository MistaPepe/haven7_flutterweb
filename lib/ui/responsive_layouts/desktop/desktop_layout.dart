import 'package:flutter/material.dart';
import 'package:haven7_flutterweb/ui/component_widgets/components.dart';

import '../../../provider/provider.dart';

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
          ? const Icon(Icons.close)
          : const Icon(Icons.menu),
      onPressed: () {
        setState(() {
          DrawerRouter.isDrawerOpen = !DrawerRouter.isDrawerOpen;
        });
      },
    );

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 248, 255),
      body: Center(
        child: Row(
          children: [
            Stack(children: [
              CustomDrawerMediumAndDesktop(),
              Positioned(top: 5, left: 10, child: menuButton),
            ]),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

