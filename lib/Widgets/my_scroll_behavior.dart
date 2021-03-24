import 'package:flutter/material.dart';

//Used to quit list's glows
class MyScrollBehavior extends ScrollBehavior{
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection){
    return child;
  }
}