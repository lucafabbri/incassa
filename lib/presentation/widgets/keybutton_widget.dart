import 'package:flutter/material.dart';
import 'package:incassa/presentation/theme.dart';

class KeyButtonWidget extends StatelessWidget {
  Function onPressed;
  ButtonStyle? buttonStyle;
  String text;

  KeyButtonWidget(String this.text,
      {required void Function() this.onPressed,
      ButtonStyle? this.buttonStyle}) {}

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SizedBox(
            height: double.maxFinite,
            child: TextButton(
              onPressed: () => {onPressed()},
              child: Text(text, style: TextStyle(fontSize: 20),),
              style: buttonStyle ?? IncassaTheme.lightTextButtonStyle,
            )));
  }
}
