import 'package:flutter/material.dart';
import 'package:incassa/presentation/widgets/keybutton_widget.dart';
import 'package:provider/provider.dart';

import '../theme.dart';
import 'package:intl/intl.dart';
import '../viewmodels/bill_viewmodel.dart';
import '../widgets/billitem_widget.dart';
import '../widgets/keyboard_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final formatCurrency =
        NumberFormat.simpleCurrency(locale: "it", decimalDigits: 2);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: IncassaTheme.primary,
        ),
        body: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
                flex: 7,
                child: Container(
                    color: Colors.blue.shade50,
                    child: const Center(child: KeyboardWidget(null)))),
            Expanded(
                flex: 3,
                child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                          left: BorderSide(width: 1, color: Colors.black12)),
                      color: Colors.white,
                    ),
                    width: 280,
                    child: Center(child: Consumer<BillViewModel>(
                        builder: (context, value, child) {
                      return Flex(
                        direction: Axis.vertical,
                        children: [
                          Expanded(
                              child: ListView(
                            padding: const EdgeInsets.all(5),
                            children: [
                              for (var item in value.items) BillItemWidget(item)
                            ],
                          )),
                          Container(
                              height: 100,
                              decoration: const BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                          width: 1, color: Colors.black12))),
                              child: Flex(direction: Axis.vertical, children: [
                                Container(
                                    padding: const EdgeInsets.all(5),
                                    child: Flex(
                                        direction: Axis.horizontal,
                                        children: [
                                          const Expanded(child: Text("Totale")),
                                          Expanded(
                                              child: Text(
                                            formatCurrency
                                                .format(value.total / 100),
                                            textAlign: TextAlign.right,
                                          ))
                                        ])),
                                KeyButtonWidget(
                                  "TOTALE",
                                  onPressed: () async =>
                                      {await printReceipt(value)},
                                  buttonStyle: totalButtonStyle(value),
                                )
                              ]))
                        ],
                      );
                    })))),
          ],
        ));
  }

  ButtonStyle totalButtonStyle(BillViewModel viewModel) {
    // return viewModel.canPrint
    //     ? IncassaTheme.lightTextButtonStyle
    //     : IncassaTheme.inactiveTextButtonStyle;
    return IncassaTheme.lightTextButtonStyle;
  }

  printReceipt(BillViewModel viewModel) async {
    // if (viewModel.canPrint) {
      await viewModel.printReceipt();
    // }
  }
}
