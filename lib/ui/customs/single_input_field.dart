import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:itex_pay/ui/consts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SingleInputFieldWidget extends StatefulWidget {

  SingleInputFieldWidget({
    Key key,
    @required this.hint,
    @required this.label,
    this.iconData,
    this.textInputType,
    this.maxLength,
    this.controller,
    this.validator,
    this.prefixWidget,
    this.autoFocus = false,
    this.isLastField = false,
    this.isPhoneNumberField = false,
    this.formatter,
    this.onChanged
  }) : super(key: key) {
    if(formatter == null) formatter = FilteringTextInputFormatter.allow(RegExp("."));
  }

  final String hint;
  final String label;
  final IconData iconData;
  final TextInputType textInputType;
  final int maxLength;
  final TextEditingController controller;
  final Function validator;
  final bool isLastField;
  final bool autoFocus;
  final Widget prefixWidget;
  final bool isPhoneNumberField;
  final Function onChanged;
  TextInputFormatter formatter;

  @override
  _SingleInputFieldWidgetState createState() => _SingleInputFieldWidgetState();
}

class _SingleInputFieldWidgetState extends State<SingleInputFieldWidget> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(child: Text(widget.label, style: textBody2,), top: 4, left: 8,),
        TextFormField(
          maxLines: 1,
          maxLength: widget.maxLength,
          keyboardType: widget.textInputType,
          controller: widget.controller,
          autofocus: widget.autoFocus,
          validator: widget.validator,
          inputFormatters: [
            widget.formatter
          ],
          onChanged: (text) {
            if(widget.onChanged != null) { widget.onChanged(text); }
          },
          textAlignVertical: TextAlignVertical.bottom,
          textInputAction: widget.isLastField ? TextInputAction.done : TextInputAction.next,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: textBody1.copyWith(color: Colors.grey),
            prefixIcon: widget.prefixWidget,
            errorMaxLines: 2,
            contentPadding: EdgeInsets.only(top: 20, left: 8, bottom: 8),
            isDense: true,
            border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(
                    color: colorPrimary
                )
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(
                    color: colorPrimary
                )
            ),
          ),
        )
      ],
    );
  }
}





class DemoInput extends StatelessWidget {
  const DemoInput({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(child: Text("DOPE"), top: 4, left: 8,),
        TextField(
          textAlignVertical: TextAlignVertical.bottom,
          decoration: InputDecoration(
            hintText: "MM/YY",
            contentPadding: EdgeInsets.only(top: 20, left: 8, bottom: 8),
            isDense: true,
            border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(
                    color: Color(0xFF0084FF)
                )
            ),
          ),
          minLines: 1,
          maxLines: 1,
        )
      ],
    );
  }
}

