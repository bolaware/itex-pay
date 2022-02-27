import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:itex_pay/ui/consts.dart';
import 'package:itex_pay/ui/customs/primary_button.dart';
import 'package:itex_pay/ui/customs/single_input_field.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({Key key}) : super(key: key);

  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16.0,),
        Row(

          children: [
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
        SvgPicture.asset("assets/success_anim.svg", package: 'itex_pay'),
        SizedBox(height: 24.0,),
        Text("Thank you, your transaction was completed successfully!", textAlign: TextAlign.center, style: textBody1,),
        SizedBox(height: 16.0,),
        PrimaryButton(
          pressListener: (){},
          text: "Okay",
          backgroundColor: colorPrimary,
        ),
        SizedBox(height: 32.0,),
      ],
    );
  }
}
