import 'package:flutter/material.dart';
import '../theme.dart';
import 'keybutton_widget.dart';
import 'keys_state.dart';

class KeyPadWidget extends StatelessWidget {
  Function onSubPressed;
  Function onPluPressed;
  Function onAcPressed;
  Function onBackPressed;
  Function onPlusValuePressed;
  Function onMinusValuePressed;
  Function onPlusPercPressed;
  Function onMinusPercPressed;
  Function onMultiplyPressed;
  Function onNumberPressed;

  KeysState keysState;

  KeyPadWidget({
    required KeysState this.keysState,
    required void Function() this.onSubPressed,
    required void Function() this.onPluPressed,
    required void Function() this.onAcPressed,
    required void Function() this.onBackPressed,
    required void Function() this.onPlusValuePressed,
    required void Function() this.onMinusValuePressed,
    required void Function() this.onPlusPercPressed,
    required void Function() this.onMinusPercPressed,
    required void Function() this.onMultiplyPressed,
    required void Function(String key) this.onNumberPressed,
  }) {}

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
            flex: 1,
            child: Flex(direction: Axis.horizontal, children: [
              KeyButtonWidget("PLU",
                  onPressed: () => {onPluPressed()},
                  buttonStyle: KeysState.stateStyleOrDefault(
                      keysState.plu, defaults: IncassaTheme.darkTextButtonStyle)),
              KeyButtonWidget("SUB",
                  onPressed: () => {onSubPressed()},
                  buttonStyle: KeysState.stateStyleOrDefault(
                      keysState.sub, defaults: IncassaTheme.darkTextButtonStyle)),
              KeyButtonWidget("AC",
                  onPressed: () => {onAcPressed()},
                  buttonStyle: KeysState.stateStyleOrDefault(
                      keysState.ac, defaults: IncassaTheme.darkTextButtonStyle)),
              KeyButtonWidget("<",
                  onPressed: () => {onBackPressed()},
                  buttonStyle: KeysState.stateStyleOrDefault(
                      keysState.back, defaults: IncassaTheme.darkTextButtonStyle)),
            ])),
        Expanded(
            flex: 1,
            child: Flex(direction: Axis.horizontal, children: [
              KeyButtonWidget("+V",
                  onPressed: () => {onPlusValuePressed()},
                  buttonStyle: KeysState.stateStyleOrDefault(
                      keysState.plusV, defaults: IncassaTheme.primaryTextButtonStyle)),
              KeyButtonWidget("-V",
                  onPressed: () => {onMinusValuePressed()},
                  buttonStyle: KeysState.stateStyleOrDefault(
                      keysState.minusV, defaults: IncassaTheme.primaryTextButtonStyle)),
              KeyButtonWidget("+%",
                  onPressed: () => {onPlusPercPressed()},
                  buttonStyle: KeysState.stateStyleOrDefault(
                      keysState.plusP, defaults: IncassaTheme.primaryTextButtonStyle)),
              KeyButtonWidget("-%",
                  onPressed: () => {onMinusPercPressed()},
                  buttonStyle: KeysState.stateStyleOrDefault(
                      keysState.minusP, defaults: IncassaTheme.primaryTextButtonStyle)),
            ])),
        Expanded(
            flex: 4,
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                    flex: 3,
                    child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        child: Flex(
                          direction: Axis.vertical,
                          children: [
                            Expanded(
                                child:
                                    Flex(direction: Axis.horizontal, children: [
                              KeyButtonWidget("7",
                                  onPressed: () => {onNumberPressed("7")},
                                  buttonStyle: 
                                      KeysState.stateStyleOrDefault(keysState.seven)),
                              KeyButtonWidget("8",
                                  onPressed: () => {onNumberPressed("8")},
                                  buttonStyle:
                                      KeysState.stateStyleOrDefault(keysState.eight)),
                              KeyButtonWidget("9",
                                  onPressed: () => {onNumberPressed("9")},
                                  buttonStyle:
                                      KeysState.stateStyleOrDefault(keysState.nine)),
                            ])),
                            Expanded(
                                child:
                                    Flex(direction: Axis.horizontal, children: [
                              KeyButtonWidget("4",
                                  onPressed: () => {onNumberPressed("4")},
                                  buttonStyle:
                                      KeysState.stateStyleOrDefault(keysState.four)),
                              KeyButtonWidget("5",
                                  onPressed: () => {onNumberPressed("5")},
                                  buttonStyle:
                                      KeysState.stateStyleOrDefault(keysState.five)),
                              KeyButtonWidget("6",
                                  onPressed: () => {onNumberPressed("6")},
                                  buttonStyle:
                                      KeysState.stateStyleOrDefault(keysState.six)),
                            ])),
                            Expanded(
                                child:
                                    Flex(direction: Axis.horizontal, children: [
                              KeyButtonWidget("1",
                                  onPressed: () => {onNumberPressed("1")},
                                  buttonStyle:
                                      KeysState.stateStyleOrDefault(keysState.one)),
                              KeyButtonWidget("2",
                                  onPressed: () => {onNumberPressed("2")},
                                  buttonStyle:
                                      KeysState.stateStyleOrDefault(keysState.two)),
                              KeyButtonWidget("3",
                                  onPressed: () => {onNumberPressed("3")},
                                  buttonStyle:
                                      KeysState.stateStyleOrDefault(keysState.three)),
                            ])),
                            Expanded(
                                child:
                                    Flex(direction: Axis.horizontal, children: [
                              KeyButtonWidget("00",
                                  onPressed: () => {onNumberPressed("00")},
                                  buttonStyle:
                                      KeysState.stateStyleOrDefault(keysState.doublezero)),
                              KeyButtonWidget("0",
                                  onPressed: () => {onNumberPressed("0")},
                                  buttonStyle:
                                      KeysState.stateStyleOrDefault(keysState.zero)),
                              KeyButtonWidget(",",
                                  onPressed: () => {onNumberPressed(".")},
                                  buttonStyle:
                                      KeysState.stateStyleOrDefault(keysState.comma)),
                            ]))
                          ],
                        ))),
                KeyButtonWidget("X",
                    onPressed: () => {onMultiplyPressed()},
                    buttonStyle: KeysState.stateStyleOrDefault(keysState.multiply, defaults: IncassaTheme.primaryTextButtonStyle))
              ],
            ))
      ],
    );
  }
}
