import 'package:flutter/material.dart';
import 'package:flutter_custom_tabbar/tab_painter.dart';

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

  //static const kLabels = ["My Team", "Today", "This Month"];
  static const kLabels = ["My Team", ];
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


