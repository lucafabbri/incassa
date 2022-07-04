import 'package:flutter/material.dart';
import 'package:incassa/theme/theme.dart';
import 'package:incassa/viewmodels/bill.dart';
import 'package:incassa/widgets/key.dart';
import 'package:incassa/widgets/keypad.dart';
import 'package:provider/provider.dart';

import '../models/Item.dart';
import '../models/department.dart';
import 'keysState.dart';

class KeyboardWidget extends StatefulWidget {
  const KeyboardWidget(Key? key) : super(key: key);

  @override
  _KeyboardWidgetState createState() => _KeyboardWidgetState();
}

class _KeyboardWidgetState extends State<KeyboardWidget> {
  final regex = RegExp(
      r'^((?<quantity>[\d]*?((,|\.)[\d]{1,2})?)x)?(?<price>[\d]+?((,|\.)[\d]{1,2})?){1}$');
  double quantity = 0;
  int price = 0;
  String message = "";
  String input = "";
  KeysState buttonsState = KeysState();
  List<Department> departments = <Department>[
    Department(1, "Reparto 1"),
    Department(2, "Reparto 2"),
    Department(3, "Reparto 3"),
    Department(4, "Reparto 4"),
  ];
  late BillViewModel bill;

  @override
  Widget build(BuildContext context) {
    bill = context.watch<BillViewModel>();

    return Container(
        width: double.infinity,
        height: double.infinity,
        child: Flex(direction: Axis.horizontal, children: [
          Expanded(
              flex: 3,
              child: Flex(
                direction: Axis.vertical,
                children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                          color: Colors.black87,
                          child: Center(
                              child: Text(
                            "${input}",
                            style: TextStyle(color: Colors.white, fontSize: 60),
                          )))),
                  Expanded(
                      flex: 1,
                      child: Container(
                          color: Colors.black87,
                          child: Center(
                              child: Text(
                            "${message}",
                            style:
                                TextStyle(color: Colors.white54, fontSize: 36),
                          )))),
                  Expanded(
                      flex: 9,
                      child: KeyPadWidget(
                          keysState: buttonsState,
                          onSubPressed: onSubPressed,
                          onPluPressed: onPluPressed,
                          onAcPressed: onAcPressed,
                          onBackPressed: onBackPressed,
                          onPlusValuePressed: onPlusValuePressed,
                          onMinusValuePressed: onMinusValuePressed,
                          onPlusPercPressed: onPlusPercPressed,
                          onMinusPercPressed: onMinusPercPressed,
                          onMultiplyPressed: onMultiplyPressed,
                          onNumberPressed: onNumberPressed))
                ],
              )),
          Expanded(
              flex: 2,
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(left: BorderSide(width: 1,color: Colors.black12)),
                  color: Colors.white,
                ),
                child:ListView(
                padding: const EdgeInsets.all(0),
                children: [
                  for (var department in departments)
                    Container(
                      height: 80,
                      child: KeyButtonWidget(
                        department.name,
                        onPressed: () => {onDepartmentPressed(department)},
                        buttonStyle: KeysState.stateStyleOrDefault(
                            buttonsState.department),
                      ),
                    ),
                ],
              )))
        ]));
  }

  void checkInput() {
    var result = "";
    final match = regex.firstMatch(input);

    if (match == null && input.length > 0) {
      errorState();
      result = "not valid";
    } else if (input.length > 0) {
      inputState();
    } else if (input.length == 0) {
      buttonsState = KeysState();
    }

    var quantity = match?.namedGroup("quantity");
    var price = match?.namedGroup("price");
    if (quantity != null && price != null) {
      result += quantity + " x " + price + "€";
      this.quantity = double.parse(quantity);
      this.price = (double.parse(price) * 100).round();
      departmentState();
    } else if (quantity == null && price != null) {
      this.quantity = 1;
      this.price = (double.parse(price) * 100).round();
      result += price + "€";
    }
    this.message = result;
  }

  void errorState() {
    setState(() {
      buttonsState.errorState();
    });
  }

  void inputState() {
    setState(() {
      buttonsState.inputState();
    });
  }

  void departmentState() {
    setState(() {
      buttonsState.departmentState();
    });
  }

  void onDepartmentPressed(Department department) {
    bill.add(
        Item(department.name, department.id, quantity: quantity, price: price));
    onAcPressed();
  }

  void onSubPressed() {
    if (buttonsState.sub == KeyStateEnum.active) {
      setState(() {
        buttonsState.sub = KeyStateEnum.hold;
        buttonsState.plu = KeyStateEnum.inactive;
      });
    } else if (buttonsState.sub == KeyStateEnum.hold) {
      onAcPressed();
    }
  }

  void onPluPressed() {
    if (buttonsState.plu == KeyStateEnum.active) {
      //send plu
    }
  }

  void onAcPressed() {
    setState(() {
      reset();
    });
  }

  void onBackPressed() {
    setState(() {
      if (input.length > 0) {
        input = input.substring(0, input.length - 1);
        checkInput();
      }
    });
  }

  void onPlusValuePressed() {
    if (bill.items.length > 0) {
      setState(() {
        bill.addSconto(DiscountItem("maggiorazione", value: -price));
        reset();
      });
    }
  }

  void onMinusValuePressed() {
    if (bill.items.length > 0) {
      setState(() {
        bill.addSconto(DiscountItem("sconto", value: price));
        reset();
      });
    }
  }

  void onPlusPercPressed() {
    if (bill.items.length > 0) {
      setState(() {
        bill.addSconto(DiscountItem("maggiorazione", percent: -price));
        reset();
      });
    }
  }

  void onMinusPercPressed() {
    if (bill.items.length > 0) {
      setState(() {
        bill.addSconto(DiscountItem("sconto", percent: price));
        reset();
      });
    }
  }

  void onMultiplyPressed() {
    setState(() {
      this.input += "x";
      checkInput();
    });
  }

  void onNumberPressed(String key) {
    setState(() {
      this.input += key;
      checkInput();
    });
  }

  void reset() {
    buttonsState = KeysState();
    input = "";
    message = "";
  }
}
