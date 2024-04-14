import 'package:flutter/material.dart';
import '../constants.dart';


class BottomButton extends StatelessWidget {
  final String? text;
  final void Function()? onTap;

  const BottomButton({this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? (){},
      child: Container(
        child: Center(child: Text(text ?? "", style: kLargeTextStyle)),
        padding: EdgeInsets.only(bottom: 20.0),
        color: kBottomBarColor,
        width: double.infinity,
        height: kBottomBarHeight,
      ),
    );
  }
}