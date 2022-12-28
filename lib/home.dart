import 'dart:math' as math;

import 'package:chrimas_tree/ring.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController rotationController;
  late Animation<double> rotationAnimation;
  late bool start;
  @override
  void initState() {
    super.initState();
    start = false;
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )
      ..forward()
      ..repeat();

    rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )
      ..forward()
      ..repeat();

    rotationAnimation =
        Tween(begin: (30 * math.pi / 180), end: (360 * math.pi / 180)).animate(
      CurvedAnimation(
        parent: rotationController,
        curve: Curves.easeInOut,
      ),
    );

    controller.addListener(() {
      setState(() {});
    });

    controller.addStatusListener((status) {
      print(status);
    });

    rotationController.addListener(() {
      setState(() {});
    });

    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        start = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    rotationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).padding.top + 40),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              if (start) ...[
                const Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: Icon(
                    Icons.star,
                    color: Colors.orange,
                  ),
                ),
                const Positioned(
                  top: -5,
                  right: 10,
                  left: 50,
                  child: Icon(
                    Icons.star,
                    color: Colors.purple,
                    size: 15,
                  ),
                ),
                const Positioned(
                  top: -5,
                  right: 50,
                  left: 10,
                  child: Icon(
                    Icons.star,
                    color: Colors.green,
                    size: 15,
                  ),
                ),
                const Positioned(
                  top: -20,
                  right: 0,
                  left: 0,
                  child: Icon(
                    Icons.star,
                    color: Colors.green,
                  ),
                ),
              ],
              for (var i = 10; i <= 150; i += 15)
                Ring(
                  controller,
                  index: i,
                  start: start,
                ),
            ],
          )),
    );
  }
}
// Stack(
// clipBehavior: Clip.none,
// children: [
// for (var i = 20; i <= 100; i += 10)
// Ring(
// index: i,
// ),
// ],
// ),
