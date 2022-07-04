import 'package:flutter/material.dart';
import 'package:incassa/viewmodels/bill.dart';
import 'package:incassa/widgets/billitem.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'widgets/keyboard.dart';
import 'package:incassa/theme/theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => BillViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Incassa'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency(locale: "it", decimalDigits: 2);
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
                                  child:
                                    Flex(direction: Axis.horizontal, children: [
                                      const Expanded(child: Text("Totale")),
                                      Expanded(
                                          child: Text(
                                        formatCurrency.format(value.total / 100),
                                        textAlign: TextAlign.right,
                                      ))
                                    ])),
                                Expanded(
                                    child: TextButton(
                                        onPressed: () => {},
                                        child: const Text("TOTALE")))
                              ]))
                        ],
                      );
                    })))),
          ],
        ));
  }
}
