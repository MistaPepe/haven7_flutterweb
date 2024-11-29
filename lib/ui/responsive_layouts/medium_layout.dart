import 'package:flutter/material.dart';
import 'package:haven7_flutterweb/provider/general.dart';
import 'package:haven7_flutterweb/ui/component_widgets/components.dart';

class MediumLayout extends StatefulWidget {
  const MediumLayout({super.key});

  @override
  State<MediumLayout> createState() => _MediumLayoutState();
}

class _MediumLayoutState extends State<MediumLayout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget tabControl() {
    if (DrawerRouter.currentPage == 'Dashboard') {
      return const DashboarLayout();
    } else {
      return const Placeholder();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomConcealingDrawer(),
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
        child: Center(
          child: Row(
            children: [
              //Drawer Widget
              // ignore: prefer_const_constructors
              CustomAnimatedDrawer(),

              //Body Widget
              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 15, 0, 5),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(232, 229, 249, 255),
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
                        CustomAppBarButtons(
                            menuFunction: () => setState(() {
                                  CustomAppBarButtons.isContainer(
                                      context, _scaffoldKey);
                                })),

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
      ),
    );
  }
}
