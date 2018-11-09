import 'package:flutter/material.dart';
class AnimationApp extends StatefulWidget {
  final Widget widget;
  AnimationApp({Key key, @required this.widget}) : super(key: key);
  _AppState createState() => new _AppState();
}

class _AppState extends State<AnimationApp> with SingleTickerProviderStateMixin {

  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = new Tween(begin: 33.0, end: 18.0).animate(
       CurvedAnimation(
          parent: controller,
          curve: Curves.bounceIn,
        )
    )
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    controller.forward();
  }

  Widget build(BuildContext context) {
    return widget;
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}