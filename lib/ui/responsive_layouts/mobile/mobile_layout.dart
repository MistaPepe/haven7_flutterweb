import 'package:flutter/material.dart';

import '../../../provider/provider.dart';
import '../../component_widgets/components.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
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

    return  Scaffold(backgroundColor: Colors.amberAccent,
    appBar: AppBar(

    ),
    drawer:const Drawer(
      child: DrawerMobile(),
    ),
    body: Center(child: Column(
      children: [
        Stack(children: [
              Positioned(top: 5, left: 10, child: menuButton),
            ]),
        Text('butu'),
      ],
    ),),);
  }
}

class DrawerMobile extends DrawerRouterList {
  const DrawerMobile({super.key});

  @override
   Widget container(List<Widget> routerList) {
    return ListView(children: routerList,);
   }
}
