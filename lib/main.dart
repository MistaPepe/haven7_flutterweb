import 'package:flutter/material.dart';
import 'package:haven7_flutterweb/ui/responsive_layout.dart';
import 'package:motion/motion.dart';


Future<void> main() async {
  await Motion.instance.initialize();
  runApp(const Websitelayout());
}
