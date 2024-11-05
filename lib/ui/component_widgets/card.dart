import 'package:flutter/material.dart';

//default template for card widget
class CardTemplateBox extends StatefulWidget {
  final int baseWidth;
  final int baseHeight;
  final Widget child;
  final Widget? background;
  const CardTemplateBox(
      {super.key,
      required this.baseWidth,
      required this.baseHeight,
      required this.child,
      this.background});

  @override
  State<CardTemplateBox> createState() => _CardTemplateBoxState();
}

class _CardTemplateBoxState extends State<CardTemplateBox> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        child: Transform.scale(
          scale: _isHovering ? 1.02 : 1.0,
          child: SizedBox(
            width: widget.baseWidth.toDouble(),
            height: widget.baseHeight.toDouble(),
            child: GestureDetector(
              onTap: () {
                debugPrint('Card tapped.');
              },
              child: Stack(
                children: [
                  widget.child,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//template for card widget showing earnings and more
class UpperCardTemplate extends StatelessWidget {
  final int numbers;
  final String title;
  final IconData icon;
  final int percentage;

  const UpperCardTemplate(
      {super.key,
      required this.numbers,
      required this.title,
      required this.icon,
      required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Background container
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 110, 229, 238),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        Column(
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.blue,
            ),
            // Title below the icon
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            // Number below the title
            Text(
              '$numbers',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
            // Percentage at the bottom
            Text(
              '+ $percentage%',
              style: TextStyle(
                fontSize: 16,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
