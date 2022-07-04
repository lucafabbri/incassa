import 'dart:collection';

import 'package:flutter/material.dart';

import '../models/Item.dart';

class BillViewModel with ChangeNotifier {
  final List<Item> _items = [];
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);
  int get total =>
      _items.isNotEmpty ?
      _items
      .map((e) => e.total)
      .reduce((value, element) => value += element) :
      0;
  int get vattotal => 
      _items.isNotEmpty ?
      _items
      .map((e) => e.vattotal)
      .reduce((value, element) => value += element) :
      0;
  int get nettotal =>  
      _items.isNotEmpty ?
      _items
      .map((e) => e.nettotal)
      .reduce((value, element) => value += element) : 
      0;

  void add(Item item) {
    var results = _items.where((element) =>
        element.description == item.description && element.price == item.price);
    if (results.isNotEmpty) {
      var d = results.first;
      d.quantity += item.quantity;
    } else {
      _items.add(item);
    }
    notifyListeners();
  }

  void addSconto(DiscountItem discount) {
    _items.last.discount = discount;
    notifyListeners();
  }

  void remove(Item item) {
    _items.remove(item);
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }
}
