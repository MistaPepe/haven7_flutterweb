import 'package:flutter/material.dart';

class CardTemplateBox extends StatefulWidget {
  final int baseWidth;
  final int baseHeight;
  final Widget child;
  const CardTemplateBox(
      {super.key,
      required this.baseWidth,
      required this.baseHeight,
      required this.child});

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
        child: AnimatedContainer(
          duration:
            const  Duration(milliseconds: 200), // Adjust animation duration as desired
          curve: Curves.easeInOut, // Customize animation curve if needed
          width: _isHovering
              ? widget.baseWidth.toDouble() + 5
              : widget.baseWidth.toDouble(), // Adjust animation
          height: _isHovering
              ? widget.baseHeight.toDouble() + 5
              : widget.baseHeight.toDouble(),
          decoration: BoxDecoration(
            color: const Color.fromARGB(28, 22, 174, 245),
            borderRadius: BorderRadius.circular(10.0), // Adjust border radius
            boxShadow: _isHovering
                ? [ 
                    BoxShadow(
                      color: const Color.fromARGB(61, 0, 148, 216).withOpacity(0.2),
                    
                    ),
                  ]
                : null, // Remove shadow on non-hover
          ),
          child: GestureDetector(
            
            onTap: () {
              debugPrint('Card tapped.');
            },
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

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
                    color: Colors.blueAccent.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                // Icon at the top
                Positioned(
                  top: 20,
                  child: Icon(
                    icon,
                    size: 40,
                    color: Colors.blue,
                  ),
                ),
                // Title below the icon
                Positioned(
                  top: 70,
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                // Number below the title
                Positioned(
                  top: 100,
                  child: Text(
                    '$numbers',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                ),
                // Percentage at the bottom
                Positioned(
                  bottom: 20,
                  child: Text(
                    '+ $percentage%',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            );
  }
}