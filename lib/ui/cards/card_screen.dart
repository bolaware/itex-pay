import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:itex_pay/blocs/bloc_provider.dart';
import 'package:itex_pay/blocs/card_bloc.dart';
import 'package:itex_pay/models/api/response_base.dart';
import 'package:itex_pay/ui/consts.dart';
import 'package:itex_pay/ui/customs/loader_widget.dart';
import 'package:itex_pay/ui/customs/primary_button.dart';
import 'package:itex_pay/ui/customs/single_input_field.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:itex_pay/ui/itex_container_screen.dart';
import 'package:itex_pay/validators/validators.dart';

class CardScreen extends StatefulWidget {

  final loaderWidget = LoaderWidget();

  CardScreen({Key key}) : super(key: key);

  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  final cardBloc = CardBloc();

  final _formKey = GlobalKey<FormState>();

  final cardNumberController = TextEditingController();
  final cvvController = TextEditingController();
  final expiryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: cardBloc,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 16.0,),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
              SvgPicture.asset("assets/card_icon.svg", package: 'itex_pay'),
              SizedBox(width: 4.0,),
              Text("Card", style: textHeadline1)
            ],),
            SizedBox(height: 16.0,),
            Text("Please enter your card details", textAlign: TextAlign.center, style: textBody1,),
            SizedBox(height: 16.0,),
            SingleInputFieldWidget(
                hint: "0000 0000 0000 0000",
                formatter: CreditCardNumberInputFormatter(),
                validator: Validators.isCardNumbermatched,
                controller: cardNumberController,
                label: "CARD NUMBER",
            ),
            SizedBox(height: 16.0,),
            Row(
              children: [
                Expanded(
                  child: SingleInputFieldWidget(
                    hint: "MM/YY",
                    formatter: CreditCardExpirationDateFormatter(),
                    validator: Validators.isExpiryNumberMatched,
                    controller: expiryController,
                    label: "EXPIRY DATE",
                  ),
                ),
                SizedBox(width: 16.0,),
                Expanded(
                  child: SingleInputFieldWidget(
                    hint: "123",
                    formatter: CreditCardCvcInputFormatter(),
                    validator: Validators.isCvvNumberMatched,
                    controller: cvvController,
                    label: "CVV",
                    isLastField: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.0,),
            PrimaryButton(
              pressListener: () async {
              EasyLoading.show(status: "Connect", maskType: EasyLoadingMaskType.black);
                //await Future.delayed(Duration(seconds: 4));
                //EasyLoading.dismiss();
                Navigator.of(context).pushNamed(pin);
/*                if(_formKey.currentState.validate()){
                  cardBloc.chargeCard(
                      cardNumberController.text,
                      cvvController.text,
                      expiryController.text
                  );
                }*/

              },
              text: "Continue",
              backgroundColor: colorPrimary,
              iconData: Icons.arrow_forward_ios,
            ),
            SizedBox(height: 32.0,),
            _networkState()
          ],
        ),
      ),
    );
  }

  Widget _networkState() {
    return StreamBuilder<BaseResponse<GenericResponse>>(
        stream: cardBloc.stream,
        builder: (context, snapshot) {
          final result = snapshot.data;
          if (result is Success) {
            widget.loaderWidget.dismiss(context);
            if (!result.hasReadData) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushNamed("/pin");
              });
              cardBloc.hasReadData(result);
            }
          } else if (result is Error) {
            widget.loaderWidget.dismiss(context);
            if (!result.hasReadData) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text((result as Error).getError().message, style: textBody1.copyWith(color: Colors.white),),
                ));
                cardBloc.hasReadData(result);
              });
            }
          } else if (result is Loading) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              widget.loaderWidget.showLoaderDialog(context);
            });
          } else {}
          return SizedBox.shrink();
        });
  }
}