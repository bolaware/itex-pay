import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:itex_pay/ui/consts.dart';
import 'package:itex_pay/ui/customs/primary_button.dart';
import 'package:itex_pay/ui/customs/single_input_field.dart';
import 'package:itex_pay/ui/itex_container_screen.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({Key key}) : super(key: key);

  @override
  _PinScreenState createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16.0,),
        Row(

          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios_outlined, color: Colors.grey, size: 16.0,)
            ),
            Expanded(
              child: Center(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    SvgPicture.asset("assets/card_icon.svg", package: 'itex_pay'),
                    SizedBox(width: 4.0,),
                    Text("Card", style: textHeadline1)
                  ],),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0,),
        Text("Enter your 4-digit card PIN to complete this transaction", textAlign: TextAlign.center, style: textBody1,),
        SizedBox(height: 16.0,),
        PinCodeTextField(
          pinBoxHeight: 40,
          pinBoxWidth: 40,
          pinBoxRadius: 10.0,
          hideCharacter: false,
          pinBoxBorderWidth: 1,
          autofocus: false,
          maxLength:4,
          wrapAlignment: WrapAlignment.center,
          //controller: codeController,
          defaultBorderColor: Colors.grey,
          hasTextBorderColor: colorPrimary,
          onDone: (String pin) {

          },
        ),
        SizedBox(height: 24.0,),
        PrimaryButton(
          pressListener: (){
            Navigator.of(context).pushNamed(otp);
          },
          text: "Continue",
          backgroundColor: colorPrimary,
        ),
        SizedBox(height: 32.0,),
      ],
    );
  }
}
