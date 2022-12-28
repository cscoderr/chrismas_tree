import 'dart:math' as math;

import 'package:flutter/material.dart';

class Ring extends StatefulWidget {
  const Ring(this.controller,
      {Key? key, required this.index, this.start = false})
      : super(key: key);

  final int index;
  final AnimationController controller;
  final bool start;

  @override
  State<Ring> createState() => _RingState();
}

class _RingState extends State<Ring> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInCirc,
          top: !widget.start ? 100 * 3 : (widget.index * 3).toDouble(),
          left: 0,
          right: 0,
          child: Transform(
            transform: Matrix4.identity()
              // ..setEntry(3, 2, 0.001)
              ..rotateX(120 * math.pi / 180),
            // ..rotateY(45 * math.pi / 180),
            child: CustomPaint(
              painter: CirclePainter(
                animation: CurvedAnimation(
                  parent: widget.controller,
                  curve: Curves.easeInQuad,
                ),
                radius: widget.index.toDouble(),
                opacity: widget.index / 200,
                currentRadius: widget.index,
              ),
            ),
          ),
        ),
        if (!widget.start && 1 == 2) ...[
          Positioned(
            left: (widget.index * 2.1).toDouble(),
            right: 0,
            top: (widget.index * 3.2).toDouble(),
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(130 * math.pi / 180),
              child: Icon(
                Icons.star,
                size: (10 + (widget.index / 5)),
                color: Colors.red,
              ),
            ),
          ),
          if (1 == 2)
            Positioned(
              left: 0,
              right: (widget.index * 2).toDouble(),
              top: (widget.index * 3).toDouble(),
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateX(130 * math.pi / 180),
                child: Icon(
                  Icons.star,
                  size: (10 + (widget.index / 5)).toDouble(),
                  color: Colors.red,
                ),
              ),
            ),
          if (1 == 2)
            Positioned(
              left: 0,
              right: 0,
              top: (widget.index * 3.8).toDouble(),
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateX(130 * math.pi / 180),
                child: Icon(
                  Icons.star,
                  size: (10 + (widget.index / 5)),
                  color: Colors.red,
                ),
              ),
            ),
        ],
      ],
    );
  }
}

class CirclePainter extends CustomPainter {
  CirclePainter({
    required this.animation,
    required this.opacity,
    this.radius = 100,
    this.currentRadius = 10,
  });
  final Animation<double> animation;
  final double radius;
  final double opacity;
  final int currentRadius;
  @override
  void paint(Canvas canvas, Size size) {
    final center = size / 2;

    const indexAngle = 358 * math.pi / 180;
    final angle = indexAngle + (math.pi * 2 * (animation.value + 0.7));

    final centerX =
        size.width / 2 + math.cos(angle) * radius * (animation.value + 0.7);
    final centerY = size.height / 2 + math.sin(angle) * radius;

    final rect = Offset(center.width, center.height) & size;

    final rect2 = Offset.zero & size;

    final paint = Paint()
      ..shader = radius == 145
          ? LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.greenAccent,
                Colors.green,
              ],
            ).createShader(rect2)
          : radius == 130
              ? LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.red,
                    Colors.redAccent,
                  ],
                ).createShader(rect2)
              : radius == 115
                  ? LinearGradient(
                      colors: [
                        Colors.yellow,
                        Colors.yellowAccent,
                      ],
                    ).createShader(rect2)
                  : (currentRadius ~/ 2) % 2 == 0
                      ? LinearGradient(
                          colors: [
                            Colors.greenAccent,
                            Colors.yellowAccent,
                          ],
                        ).createShader(rect2)
                      : LinearGradient(
                          colors: [
                            Colors.greenAccent,
                            Colors.redAccent,
                          ],
                        ).createShader(rect2)
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      // ..maskFilter = MaskFilter.blur(BlurStyle.normal, convertRadiusToSigma(3))
      ..style = PaintingStyle.stroke;

    final centerOffset = Offset(center.width, center.height);
    // canvas.drawCircle(
    //   centerOffset,
    //   radius,
    //   paint,
    // );

    canvas.drawArc(
      Rect.fromCircle(center: centerOffset, radius: radius),
      angle,
      indexAngle,
      false,
      paint,
    );

    final centerXOffset = size.width / 2 + math.cos(180) * radius * (0.7) - 10;
    final centerYOffset = size.height / 2 + math.sin(30) * radius - 10;

    const icon = Icons.star_outline;
    TextPainter textPainter = TextPainter(textDirection: TextDirection.rtl);
    textPainter.text = TextSpan(
      text: String.fromCharCode(icon.codePoint),
      style: TextStyle(
        fontSize: 10 + (currentRadius / 4),
        fontFamily: icon.fontFamily,
        color: Colors.redAccent,
      ),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(centerXOffset, centerYOffset));

    final centerXOffset1 =
        size.width / 2 + math.cos(angle) * radius * (0.7) - 10;
    final centerYOffset1 = size.height / 2 + math.sin(30) * radius - 10;

    TextPainter textPainter1 = TextPainter(textDirection: TextDirection.rtl);
    textPainter1.text = TextSpan(
      text: String.fromCharCode(icon.codePoint),
      style: TextStyle(
        fontSize: 10 + (currentRadius / 4),
        fontFamily: icon.fontFamily,
        color: Colors.greenAccent,
      ),
    );
    textPainter1.layout();
    textPainter1.paint(canvas, Offset(centerXOffset1, centerYOffset1));

    final centerXOffset2 = size.width / 2 + math.cos(20) * radius * (0.7) - 10;
    final centerYOffset2 = size.height / 2 + math.sin(30) * radius - 10;

    TextPainter textPainter2 = TextPainter(textDirection: TextDirection.rtl);
    textPainter2.text = TextSpan(
      text: String.fromCharCode(icon.codePoint),
      style: TextStyle(
        fontSize: 10 + (currentRadius / 4),
        fontFamily: icon.fontFamily,
        color: Colors.purpleAccent,
      ),
    );
    textPainter2.layout();
    textPainter2.paint(canvas, Offset(centerXOffset2, centerYOffset2));
    canvas.save();
    // canvas.transform(Matrix4.identity()
    //   ..setEntry(3, 2, 0.001)
    //   ..rotateX(130 * math.pi / 180));
    canvas.restore();

//(animation.value + 0.9
    if (1 == 2) {
      for (var index = 0; index < 3; index++) {
        const indexAngle = 360 * math.pi / 180;
        final angle = indexAngle + (math.pi * 2 * (animation.value + 0.7));

        final centerX =
            size.width / 2 + math.cos(angle) * currentRadius - (15 * index);
        final centerY = size.height / 2 + math.sin(angle) * currentRadius - 10;

        final center = Offset(centerX, centerY);
        const icon = Icons.star_outline;
        TextPainter textPainter = TextPainter(textDirection: TextDirection.rtl);
        textPainter.text = TextSpan(
          text: String.fromCharCode(icon.codePoint),
          style: TextStyle(
            fontSize: 10 + (currentRadius / 4),
            fontFamily: icon.fontFamily,
            color: index % 2 == 0 ? Colors.yellowAccent : Colors.redAccent,
          ),
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(centerX, centerY));
      }
    }

    // for (var index = 0; index < numberOfObjects; index++) {
    //   _paint.color = index % 2 == 0 ? Color(0xFFAEC5EB) : Colors.pinkAccent;
    //
    //   final indexAngle = (index * math.pi * 2 / numberOfObjects);
    //   final angle = indexAngle + (math.pi * 2 * (animation.value + 0.9));
    //
    //   final centerX =
    //       size.width / 2 + math.cos(angle) * radius * (animation.value + 0.9);
    //   final centerY = size.height / 2 + math.sin(angle) * radius;
    //
    //   final center = Offset(centerX, centerY);
    //   canvas.drawCircle(center, (radius / 20), _paint);
    // }
  }

  static double convertRadiusToSigma(double radius) {
    return radius * 0.57735 + 0.5;
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(CirclePainter oldDelegate) => false;
}
