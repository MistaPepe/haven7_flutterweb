import 'package:flutter/material.dart';
import '../component_widgets/components.dart';

class DesktopLayout extends StatefulWidget {
  const DesktopLayout({super.key});

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}


class _DesktopLayoutState extends State<DesktopLayout> {
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 41, 158),
      body: Center(
        child: Row(
          children: [
            //Drawer Widget, tho it is in constant open state, so i guess it just a router not a drawer

             const CustomAnimatedDrawer(),

            //Body Widget
             Expanded(
              child: Container(
                  margin:const EdgeInsets.fromLTRB(0, 15, 10, 5),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 236, 236, 236),
                    borderRadius: BorderRadius.all(
                     Radius.circular(20)
                    )),
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
                          CardStatisticsWrapper(),
                          const SizedBox(height: 20),
                          const CardTemplateBox(
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
            ),
          ],
        ),
      ),
    );
  }}