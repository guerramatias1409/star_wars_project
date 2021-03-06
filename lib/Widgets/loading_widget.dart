import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import '../Utils/constants.dart';

class LoadingWidget extends StatefulWidget {
  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> with SingleTickerProviderStateMixin{
  AnimationController controller;
  Animation<int> animation;
  
  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 3000));
    animation = IntTween(begin: 0, end: THREE_DOTS.length).animate(controller);
    controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget child){
        return BorderedText(
          strokeWidth: 4,
          strokeColor: Color(0xFFFFE444),
          child: Text(
            LOADING.toUpperCase()+THREE_DOTS.substring(0, animation.value),
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.black,
              fontSize: 45,
              decoration: TextDecoration.none,
            ),
          ),
        );
      },
    )
    );
  }
}
