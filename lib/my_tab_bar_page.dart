import 'package:flutter/material.dart';

enum TabStyle {
  leftTab,
  rightTab,
  centerTab,
  singleTab,
}

class MyTabBarPage extends StatefulWidget {
  const MyTabBarPage({super.key});

  @override
  State<MyTabBarPage> createState() => _MyTabBarPageState();
}

class _MyTabBarPageState extends State<MyTabBarPage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  static const kLabels = ["My Team", "Today", "This Month"];
  static const kTabFgColor = Color(0xff4e46a9);
  static const kTabBgColor  = Colors.white;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: kLabels.length, vsync: this);
    _controller.addListener(() {
      setState(() {}); // force rebuild when index changes
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
          iconTheme: IconThemeData(
              color: Color(0xff4e46a9)
          ),

          centerTitle: true,

          title: const Text('MyTabBar Demo',style: TextStyle(color: Color(0xff4e46a9)),)
      ),
      body: Column(
        children: [
          MyTabBar(
            controller: _controller,
            labels: kLabels,
            backgroundColor: kTabBgColor,
            foregroundColor: kTabFgColor,
            fontSize: 14,
          ),
          Expanded(
            child: TabBarView(
              controller: _controller,
              children: kLabels
                  .map((label) => Center(child: Text(label,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40,color: Color(0xff4e46a9)),)))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class MyTabBar extends StatelessWidget {
  final TabController controller;
  final List<String> labels;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? activeBackgroundColor;
  final Color? activeForegroundColor;
  final double fontSize;

  const MyTabBar({
    super.key,
    required this.controller,
    required this.labels,
    required this.backgroundColor,
    required this.foregroundColor,
    this.activeBackgroundColor,
    this.activeForegroundColor,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final length = labels.length;

    return AspectRatio(
      aspectRatio: 100 / 18,
      child: Stack(
        fit: StackFit.expand,
        children: List.generate(length, (index) {
          final active = controller.index == index;

          TabStyle style;
          if (length == 1) {
            style = TabStyle.singleTab;
          } else if (length == 2) {
            style = index == 0 ? TabStyle.leftTab : TabStyle.rightTab;
          } else {
            style = index == 0
                ? TabStyle.leftTab
                : index == 1
                ? TabStyle.centerTab
                : TabStyle.rightTab;
          }

          return active
              ? MyTab(
            active: active,
            style: style,
            length: length,
            label: labels[index],
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            activeBackgroundColor: activeBackgroundColor,
            activeForegroundColor: activeForegroundColor,
            fontSize: fontSize,
            onTap: () => controller.animateTo(index),
          )
              : Align(
            alignment: () {
              switch (style) {
                case TabStyle.leftTab:
                  return Alignment.centerLeft;
                case TabStyle.rightTab:
                  return Alignment.centerRight;
                default:
                  return Alignment.center;
              }
            }(),
            child: FractionallySizedBox(
              widthFactor: (length == 1)
                  ? 1.0
                  : (length == 2)
                  ? 0.5
                  : (style == TabStyle.centerTab ? 0.34 : 0.33),
              heightFactor: 1,
              child: TextButton(
                onPressed: () => controller.animateTo(index),
                child: Text(
                  labels[index],
                  style: TextStyle(
                    color: foregroundColor,
                    fontSize: fontSize,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class MyTab extends StatelessWidget {
  final bool active;
  final TabStyle style;
  final int length;
  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? activeBackgroundColor;
  final Color? activeForegroundColor;
  final double fontSize;
  final VoidCallback onTap;

  const MyTab({
    super.key,
    required this.active,
    required this.style,
    required this.length,
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    this.activeBackgroundColor,
    this.activeForegroundColor,
    required this.fontSize,
    required this.onTap,
  });

  Color get bgColor =>
      active ? activeBackgroundColor ?? foregroundColor : backgroundColor;

  Color get fgColor =>
      active ? activeForegroundColor ?? backgroundColor : foregroundColor;

  @override
  Widget build(BuildContext context) {
    Alignment align;
    switch (style) {
      case TabStyle.leftTab:
        align = Alignment.centerLeft;
        break;
      case TabStyle.rightTab:
        align = Alignment.centerRight;
        break;
      default:
        align = Alignment.center;
    }

    final widthFactor = (length == 1)
        ? 1.0
        : (length == 2)
        ? 0.5
        : (style == TabStyle.centerTab ? 0.34 : 0.33);

    return Stack(
      children: [
        Positioned.fill(
          child: IgnorePointer(
            child: CustomPaint(
              painter: TabPainter(
                color: bgColor,
                style: style,
                length: length,
              ),
            ),
          ),
        ),
        Align(
          alignment: align,
          child: FractionallySizedBox(
            widthFactor: widthFactor,
            heightFactor: 1,
            child: TextButton(
              onPressed: active ? null : onTap,
              child: Text(
                label,
                style: TextStyle(color: fgColor, fontSize: fontSize),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}


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