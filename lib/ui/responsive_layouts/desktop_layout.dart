import 'package:flutter/material.dart';
import '../../provider/provider.dart';
import '../component_widgets/components.dart';

class DesktopLayout extends StatefulWidget {
  const DesktopLayout({super.key});

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}


class _DesktopLayoutState extends State<DesktopLayout> {

    Widget tabControl() {
    if (DrawerRouter.currentPage == 'Dashboard') {
      return const DashboardDesktop();
    } else {
      return const Placeholder();
    }
  }
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
                      tabControl(),
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

  class DashboardDesktop extends StatelessWidget {
  const DashboardDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: Column(
          children: [
            const CardStatisticsWrapper(),
            Flexible(child: Row(
              children: [
                Flexible(child: GraphOverallSales()),

              ],
            ))
          ],
        ),
      ),
    );
  }
}