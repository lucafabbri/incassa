import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../domain/item.dart';
import '../../domain/discount.dart';
import '../viewmodels/bill_viewmodel.dart';

class BillItemWidget extends StatelessWidget {
  Item item;
  BillItemWidget(this.item, {Key? key}) : super(key: key);
  final formatCurrency =
      NumberFormat.simpleCurrency(locale: "it", decimalDigits: 2);

  @override
  Widget build(BuildContext context) {
    var bill = context.watch<BillViewModel>();
    List<Widget> children = [];

    children.add(Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Flex(
            direction: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 4,
                  child: Text(item.description.toString(),
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 16))),
              Expanded(
                  flex: 3,
                  child: Text(formatQuantity(item.quantity.toString()),
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontSize: 16))),
              Expanded(
                  flex: 3,
                  child: Text(formatCurrency.format(item.price / 100),
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontSize: 16))),
            ])));
    if (item.discount != null) {
      children.add(Container(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Flex(
              direction: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(flex: 4, child: Text("")),
                Expanded(
                    flex: 3,
                    child: Text(formatDiscount(item.discount),
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black54))),
                Expanded(
                    flex: 3,
                    child: Text(formatDiscountTotal(item.discounttotal / 100),
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black54))),
              ])));
    }
    return Dismissible(
      key: Key(item.id),
      background: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.red),
        margin: const EdgeInsets.all(5),
        child: const Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Icon(Icons.delete, color: Color.fromARGB(255, 255, 187, 187),),
          ),
        ),
      ),
      onDismissed: (_) {
        bill.remove(item);
      },
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color.fromARGB(15, 0, 0, 0)),
        margin: const EdgeInsets.all(5),
        child: Flex(direction: Axis.vertical, children: children),
      ),
    );
  }

  String formatDiscount(Discount? discount) {
    if (discount?.percent != null) {
      return "${-((discount?.percent ?? 0) / 100).round()}%";
    } else {
      return "";
    }
  }

  String formatDiscountTotal(double discount) {
    if (discount < 0) {
      return "+" + formatCurrency.format(-discount);
    } else {
      return formatCurrency.format(-discount);
    }
  }

  String formatQuantity(String quantity) {
    if (quantity.endsWith(".0")) {
      quantity = quantity.replaceAll(".0", "");
    }
    return quantity + "x";
  }
}
