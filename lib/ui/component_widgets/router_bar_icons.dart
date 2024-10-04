import 'package:flutter/material.dart';
import '../../provider/provider.dart';


// building block for icon and the name of the router
mixin RouterList {
  Widget routerRow(
      BuildContext context, String name, IconData icon, bool isHover) {
    List<Color> getGradientColors() {
      if (DrawerRouter.currentPage == name) {
        return [Colors.blue.shade200, Colors.blue.shade400];
      } else if (isHover) {
        return [const Color.fromARGB(255, 66, 108, 245), const Color.fromARGB(255, 21, 61, 192)];
      } else {
        return [const Color.fromARGB(0, 245, 55, 55), Colors.transparent];
      }
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: getGradientColors()),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 30),
            if (DrawerRouter.isDrawerOpen) const SizedBox(width: 20),
            if (DrawerRouter.isDrawerOpen)
              Text(
                name,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}

// blueprint that access the admindrawer class to form drawer
abstract class DrawerRouterList extends StatefulWidget with RouterList {
  const DrawerRouterList({super.key});

  Widget container(List<Widget> routerList);

  @override
  State<DrawerRouterList> createState() => _DrawerRouterListState();
}

class _DrawerRouterListState extends State<DrawerRouterList> {
  List<Widget> routerList() {
    return AdminDrawer.values.asMap().entries.map((entry) {
      final int index = entry.key;
      final AdminDrawer item = entry.value;
      return Builder(builder: (context) {
        return MouseRegion(
          onEnter: (_) => setState(() {
            DrawerRouter.isHovered[index] = true;
          }),
          onExit: (_) => setState(() {
           DrawerRouter.isHovered[index] = false;
          }),
          child: GestureDetector(
              onTap: () {
                setState(() {
                  DrawerRouter.currentPage = item.name;
                });
              },
              child: widget.routerRow(
                  context, item.name, item.icon, DrawerRouter.isHovered[index])),
        );
      });
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return widget.container((routerList()));
  }
}

class CustomDrawerMediumAndDesktop extends DrawerRouterList {
  const CustomDrawerMediumAndDesktop({super.key});

  @override
  Widget container(List<Widget> routerList) {
    return AnimatedContainer(
      duration:const Duration(milliseconds: 250),
      width: DrawerRouter.isDrawerOpen ? 220 : 75,
      height: double.infinity,
      color: const Color.fromARGB(255, 0, 14, 145),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 60, 5, 0),
        child: ListView(
          children: routerList,
        ),
      ),
    );
  }
}
