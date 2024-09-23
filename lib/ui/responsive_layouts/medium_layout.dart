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
      icon: isDrawerOpen
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
          isDrawerOpen = !isDrawerOpen;
        });
      },
    );
    return Scaffold(
      backgroundColor: const Color.fromARGB(221, 0, 0, 32),
      body: Center(
        child: Row(
          children: [
            Stack(children: [
              CustomDrawerMedium(),
              Positioned(top: 5, left: 10, child: menuButton),
            ]),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
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
      width: isDrawerOpen ? 250 : 80,
      height: double.infinity,
      color: const Color.fromARGB(61, 0, 148, 216),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 60, 5, 0),
        child: ListView(
          children: routerList,
        ),
      ),
    );
  }
}
