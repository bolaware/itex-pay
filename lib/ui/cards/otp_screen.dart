import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:itex_pay/ui/consts.dart';
import 'package:itex_pay/ui/customs/primary_button.dart';
import 'package:itex_pay/ui/customs/single_input_field.dart';
import 'package:itex_pay/ui/itex_container_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key key}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16.0,),
        Row(

          children: [
            Icon(Icons.arrow_back_ios_outlined, color: Colors.grey, size: 16.0,),
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
        Text("Please provide the OTP sent to the mobile to complete your payment", textAlign: TextAlign.center, style: textBody1,),
        SizedBox(height: 16.0,),
        SingleInputFieldWidget(
            hint: "1234",
            label: "0TP",
            maxLength: 4,
            textInputType: TextInputType.number,
        ),
        SizedBox(height: 24.0,),
        PrimaryButton(
          pressListener: (){
            Navigator.of(context).pushNamed(success);
          },
          text: "Continue",
          backgroundColor: colorPrimary,
        ),
        SizedBox(height: 24.0,),
        RichText(
          text: TextSpan(
            text: 'Didnt receive OTP? - ',
            style: textBody1,
            children: <TextSpan>[
              TextSpan(text: 'Resend', style: textBody1.copyWith(fontWeight: FontWeight.bold, color: Color(0xFF5DCC97))),
            ],
          ),
        ),
        SizedBox(height: 32.0,),
      ],
    );
  }
}
