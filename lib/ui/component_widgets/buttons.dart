import 'package:flutter/material.dart';

import '../../provider/provider.dart';

class CustomAppBarButtons extends StatelessWidget {
  final bool hasMenuButton;
  final Function? menuFunction;
  
  const CustomAppBarButtons(
      {super.key,
      this.hasMenuButton = true,
      this.menuFunction});

  static void isContainer(
      BuildContext context, GlobalKey<ScaffoldState>? scaffoldKey) {
    (MediaQuery.of(context).size.width < 950)
              ? scaffoldKey?.currentState?.openDrawer()
              : DrawerRouter.isDrawerOpen = !DrawerRouter.isDrawerOpen;
  }

  @override
  Widget build(BuildContext context) {

    var menuButton = IconButton(
      icon: DrawerRouter.isDrawerOpen
          ? const Icon(
              Icons.close,
              color: Colors.black,
            )
          : const Icon(
              Icons.menu,
              color: Colors.black,
            ),
      onPressed: () => menuFunction!(),
    );
    
    return Row(
      children: [
        (hasMenuButton) ? menuButton : const SizedBox(),
        //appbar widget
        Expanded(
            child: Align(
                alignment: Alignment.centerRight,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.notifications_none,
                    ),
                    iconSize: 30,
                    onPressed: () {},
                  ),
                ))),
      ],
    );
  }
}
