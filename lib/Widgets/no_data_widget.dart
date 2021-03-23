import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:star_wars_project/constants.dart';

class NoDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 300,
        child: Center(
          child: BorderedText(
            strokeWidth: 2.5,
            strokeColor: Color(0xFFFFE444),
            child: Text(
              NO_DATA.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
