import 'package:flutter/material.dart';
import 'package:haven7_flutterweb/ui/component_widgets/components.dart';

class MediumLayout extends StatefulWidget {
  const MediumLayout({super.key});

  @override
  State<MediumLayout> createState() => _MediumLayoutState();
}

class _MediumLayoutState extends State<MediumLayout> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 1, 0, 22),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: CustomDrawer(),
        ),
      ),
    );
  }
}

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool _isOpen = false;

  List<CustomSideBarIcon> generateSideBarContent(bool isOpen) {
    return [
      for (var icon in sideBarIcons.entries)
        CustomSideBarIcon(
            routeName: icon.key, icon: icon.value, isOpen: isOpen),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeIn,
          width: _isOpen ? 300 : 60,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
                color: Colors.grey[200],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...generateSideBarContent(_isOpen),
                    IconButton(
                      icon: Icon(_isOpen ? Icons.close : Icons.menu),
                      onPressed: () {
                        setState(() {
                          _isOpen = !_isOpen;
                        });
                      },
                    ),
                  ],
                )),
          ),
        ),
        Flexible(
            child: GridView.builder(
          itemCount: 5,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20,0,0,20),
              child: GlassCard(
                  child: MyPieChart(
                pieChartData: pieChartData,
              )),
            );
          },
        ))
      ],
    );
  }
}

class CustomSideBarIcon extends StatelessWidget {
  final bool isOpen;
  final String routeName;
  final Icon icon;
  const CustomSideBarIcon(
      {super.key,
      required this.routeName,
      required this.icon,
      required this.isOpen});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          IconTheme(data: const IconThemeData(
            size: 30,
          ), child: icon),
          const SizedBox(width: 8),
          if (isOpen)
            Text(
              routeName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
        
            ),
        ],
      ),
    );
  }
}
