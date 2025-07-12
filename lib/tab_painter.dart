import 'package:flutter/material.dart';

import 'my_tab_bar_page.dart';

class TabPainter extends CustomPainter {
  final Color color;
  final TabStyle style;
  final int length;

  TabPainter({required this.color, required this.style, required this.length});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..style = PaintingStyle.fill;
    final path = Path();

    switch (style) {
      case TabStyle.leftTab:
        _drawLeftTab(path, size);
        break;
      case TabStyle.rightTab:
        _drawRightTab(path, size);
        break;
      case TabStyle.centerTab:
        _drawCenterTab(path, size);
        break;
      case TabStyle.singleTab:
        _drawSingleTab(path, size);
        break;
    }

    canvas.drawPath(path, paint);
  }

  void _drawLeftTab(Path path, Size size) {
    path.moveTo(0, size.height);
    path.lineTo(0, .5 * size.height);
    path.quadraticBezierTo(0, 0, .1 * size.width, 0);
    if (length == 2) {
      path.lineTo(.48 * size.width, 0);
      path.quadraticBezierTo(.512 * size.width, 0, .52 * size.width, .1 * size.height);
      path.lineTo(.57 * size.width, .83 * size.height);
      path.quadraticBezierTo(.58 * size.width, .9 * size.height, .59 * size.width, .9 * size.height);
      path.lineTo(size.width, .9 * size.height);
    } else if (length == 3) {
      path.lineTo(.28 * size.width, 0);
      path.quadraticBezierTo(.312 * size.width, 0, .32 * size.width, .1 * size.height);
      path.lineTo(.37 * size.width, .83 * size.height);
      path.quadraticBezierTo(.38 * size.width, .9 * size.height, .39 * size.width, .9 * size.height);
      path.lineTo(size.width, .9 * size.height);
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
  }

  void _drawRightTab(Path path, Size size) {
    path.moveTo(size.width, size.height);
    path.lineTo(size.width, .5 * size.height);
    path.quadraticBezierTo(size.width, 0, .9 * size.width, 0);
    if (length == 2) {
      path.lineTo(.52 * size.width, 0);
      path.quadraticBezierTo(.488 * size.width, 0, .48 * size.width, .1 * size.height);
      path.lineTo(.43 * size.width, .83 * size.height);
      path.quadraticBezierTo(.42 * size.width, .9 * size.height, .41 * size.width, .9 * size.height);
      path.lineTo(0, .9 * size.height);
    } else if (length == 3) {
      path.lineTo(.72 * size.width, 0);
      path.quadraticBezierTo(.688 * size.width, 0, .68 * size.width, .1 * size.height);
      path.lineTo(.63 * size.width, .83 * size.height);
      path.quadraticBezierTo(.62 * size.width, .9 * size.height, .61 * size.width, .9 * size.height);
      path.lineTo(0, .9 * size.height);
    }
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
  }

  void _drawCenterTab(Path path, Size size) {
    final trapeziumWidth = size.width * 0.5;
    final left = (size.width - trapeziumWidth) / 2;
    final right = left + trapeziumWidth;
    final height = size.height;
    path.moveTo(0, height);
    path.lineTo(0, 0.9 * height);
    path.lineTo(left, 0.9 * height);
    path.quadraticBezierTo(left + 0.03 * trapeziumWidth, 0.9 * height,
        left + 0.05 * trapeziumWidth, 0.8 * height);
    path.lineTo(left + 0.2 * trapeziumWidth, 0.2 * height);
    path.quadraticBezierTo(
        left + 0.23 * trapeziumWidth, 0, left + 0.3 * trapeziumWidth, 0);
    path.lineTo(left + 0.7 * trapeziumWidth, 0);
    path.quadraticBezierTo(
        left + 0.77 * trapeziumWidth, 0, left + 0.8 * trapeziumWidth, 0.2 * height);
    path.lineTo(left + 0.95 * trapeziumWidth, 0.8 * height);
    path.quadraticBezierTo(
        left + 0.97 * trapeziumWidth, 0.9 * height, right, 0.9 * height);
    path.lineTo(size.width, 0.9 * height);
    path.lineTo(size.width, height);
    path.lineTo(0, height);
    path.close();
  }

  void _drawSingleTab(Path path, Size size) {
    final height = size.height;
    path.moveTo(0, height);
    path.lineTo(0, 0.9 * height);
    path.quadraticBezierTo(0.05 * size.width, 0.9 * height, 0.1 * size.width, 0.8 * height);
    path.lineTo(0.25 * size.width, 0.2 * height);
    path.quadraticBezierTo(0.28 * size.width, 0, 0.35 * size.width, 0);
    path.lineTo(0.65 * size.width, 0);
    path.quadraticBezierTo(0.72 * size.width, 0, 0.75 * size.width, 0.2 * height);
    path.lineTo(0.9 * size.width, 0.8 * height);
    path.quadraticBezierTo(0.95 * size.width, 0.9 * height, size.width, 0.9 * height);
    path.lineTo(size.width, height);
    path.lineTo(0, height);
    path.close();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}