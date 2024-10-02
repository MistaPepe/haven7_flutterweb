import 'package:flutter/material.dart';

class CardTemplate extends StatefulWidget {
  final int baseWidth;
  final int baseHeight;
  final Widget child;
  const CardTemplate(
      {super.key,
      required this.baseWidth,
      required this.baseHeight,
      required this.child});

  @override
  State<CardTemplate> createState() => _CardTemplateState();
}

class _CardTemplateState extends State<CardTemplate> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
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
    );
  }
}


