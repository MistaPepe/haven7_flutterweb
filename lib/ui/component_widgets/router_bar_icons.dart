import 'package:flutter/material.dart';
import '../../provider/provider.dart';

mixin RouterList {
  Widget routerRow(
      BuildContext context, String name, IconData icon) {

List<Color> getGradientColors() {
  if (currentPage == name) {
    return [Colors.blue.shade200, Colors.blue.shade400];
  } 
  else {
    return [Colors.transparent, Colors.transparent];
  }
}
    return GestureDetector(
      child: ClipRRect(
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
              if (isDrawerOpen) const SizedBox(width: 20),
              if (isDrawerOpen)
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white
                  ),
                ),
            ],
          ),
        ),
      ),
      onTap: () {
        //TODO
        // Navigate to the corresponding screen
        //Navigator.pushReplacementNamed(context, item.router);
      },
    );
  }
}

abstract class DrawerRouterList extends StatefulWidget with RouterList {
  const DrawerRouterList({super.key});

  Widget container(List<Widget> routerList);

  @override
  State<DrawerRouterList> createState() => _DrawerRouterListState();
}

class _DrawerRouterListState extends State<DrawerRouterList> {
    List<Widget> routerList() {
    return AdminDrawer.values.map((item) {
      return widget.routerRow(context, item.name, item.icon);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return widget.container((routerList()));
  }
}
