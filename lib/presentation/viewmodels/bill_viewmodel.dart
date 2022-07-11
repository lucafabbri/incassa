import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:RCHGatewayClient/api.dart';

import '../../data/mappers/extensions.dart';

import '../../application/print_service.dart';
import '../../domain/bill.dart' as domain;
import '../../domain/item.dart' as domain;
import '../../domain/discount.dart' as domain;
import '../../domain/payment.dart' as domain;

class BillViewModel with ChangeNotifier {
  final PrintService printService = PrintService();
  domain.Bill bill = domain.Bill();
  bool isPrinting = false;
  bool get canPrint => !isPrinting && bill.orders[0].lineItems.isNotEmpty;

  UnmodifiableListView<domain.Item> get items =>
      UnmodifiableListView(bill.orders[0].lineItems);

  int get total => bill.orders[0].lineItems.isNotEmpty
      ? bill.orders[0].lineItems
          .map((e) => e.total)
          .reduce((value, element) => value += element)
      : 0;
  int get vattotal => bill.orders[0].lineItems.isNotEmpty
      ? bill.orders[0].lineItems
          .map((e) => e.vattotal)
          .reduce((value, element) => value += element)
      : 0;
  int get nettotal => bill.orders[0].lineItems.isNotEmpty
      ? bill.orders[0].lineItems
          .map((e) => e.nettotal)
          .reduce((value, element) => value += element)
      : 0;

  void add(domain.Item item) {
    var results = bill.orders[0].lineItems.where((element) =>
        element.description == item.description && element.price == item.price);
    if (results.isNotEmpty) {
      var d = results.first;
      d.quantity += item.quantity;
    } else {
      bill.orders[0].lineItems.add(item);
    }
    notifyListeners();
  }

  void addPercDiscount(int value) {
    bill.orders[0].lineItems.last.discount =
        domain.Discount("sconto", percent: value);
    notifyListeners();
  }

  void addValueDiscount(int value) {
    bill.orders[0].lineItems.last.discount =
        domain.Discount("sconto", value: value);
    notifyListeners();
  }

  void addPercIncrease(int value) {
    bill.orders[0].lineItems.last.discount =
        domain.Discount("maggiorazione", percent: -value);
    notifyListeners();
  }

  void addValueIncrease(int value) {
    bill.orders[0].lineItems.last.discount =
        domain.Discount("maggiorazione", value: -value);
    notifyListeners();
  }

  void remove(domain.Item item) {
    bill.orders[0].lineItems.remove(item);
    notifyListeners();
  }

  void removeAll() {
    bill.orders[0].lineItems.clear();
    notifyListeners();
  }

  void _startPrinting() {
    isPrinting = true;
    notifyListeners();
  }

  void _finishPrinting() {
    isPrinting = false;
    notifyListeners();
  }

  Future printReceipt() async {
    bill.paymentItems.clear();
    bill.paymentItems.add(domain.Payment(1));

    _startPrinting();
    try{
      var result = await printService.print(true, bill.toGatewayBill());
      result.matchFirst((value) {
        bill = domain.Bill();
        _finishPrinting();
      }, (error) {
        print(error);
        _finishPrinting();
      });
    }on Exception{
      _finishPrinting();
    }
  }
}
