import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:itex_pay/ui/consts.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key key,
    @required this.text,
    @required this.pressListener,
    this.backgroundColor,
    this.textColor = Colors.white,
    this.iconData
  }) : super(key: key);

  final Function pressListener;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: 50.00,
        child: ElevatedButton(
          child: Stack(
            children: [
              Container(width: double.infinity, height: 25.0,),
              Positioned.fill(
                right: 15.0,
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: textHeadline2.copyWith(
                      fontWeight: FontWeight.bold,
                      color: textColor
                  ),),
              ),
              Positioned(
                right: 4.0,
                top: 4.0,
                child: iconData != null ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Icon(iconData, size: 16.0,),
                ) : SizedBox.shrink(),
              ),
            ],
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  backgroundColor ?? colorPrimary
              ),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)
                )
            ),
          ),
          onPressed: () {
            pressListener();
          },
        ),
      ),
    );
  }
}