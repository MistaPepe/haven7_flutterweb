import 'package:flutter/material.dart';

import '../../provider/provider.dart';

class CustomCallbackButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Icon? icon;
  final String? image;
  final double? paddingHeight;
  final double? paddingWidth;
  final bool dividerForicon;


  const CustomCallbackButton(
      {required this.text,
      required this.onPressed,
      super.key,
      this.icon,
      this.image, this.paddingHeight, this.paddingWidth,  this.dividerForicon = false,
     });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: IntrinsicWidth(
        // Wrap with IntrinsicWidth
        child: MouseRegion(
           cursor: SystemMouseCursors.click,
          child: Container(
            decoration: BoxDecoration(
              image:(image == null) ? null : DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  image!,
                ),
              ),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF007BFF), // Start color
                  Color(0xFF0056D6), // End color
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16), // Rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(2, 4), // Shadow position
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(vertical: paddingHeight ?? 12, horizontal: paddingWidth ?? 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                //Divider for text and icon
                (dividerForicon)
                    ? Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Divider()!,
                    )
                    : const SizedBox(),
                // If icon exists
                (icon != null)
                    ? Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: icon!,
                    )
                    : const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomAppBarButtons extends StatelessWidget {
  final bool hasMenuButton;
  final Function? menuFunction;

  const CustomAppBarButtons(
      {super.key, this.hasMenuButton = true, this.menuFunction});

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
        const Expanded(
            child: Align(
                alignment: Alignment.centerRight,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: BellNotification(
                    notification: 99,
                  ),
                ))),
      ],
    );
  }
}

class BellNotification extends StatelessWidget {
  final int notification;
  const BellNotification({super.key, this.notification = 0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior:
          Clip.none, // Allows the badge to appear outside the CircleAvatar
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.notifications_none,
            ),
            iconSize: 30,
            onPressed: () {
              // Your notification logic
            },
          ),
        ),
        // Badge to show the notification indicator
        Positioned(
          right: -5, // Adjust the position of the badge
          top: -5,
          child: Container(
            padding: const EdgeInsets.all(2), // Padding for the badge
            decoration: BoxDecoration(
              color: (notification != 0)
                  ? Colors.red
                  : Colors.transparent, // Background color of the badge
              shape: BoxShape.circle,
            ),
            constraints: const BoxConstraints(
              minWidth: 16,
              minHeight: 16, // Minimum size for the badge
            ),
            child: Text(
              notification.toString(), // Number of notifications
              style: TextStyle(
                color: (notification != 0) ? Colors.white : Colors.transparent,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
