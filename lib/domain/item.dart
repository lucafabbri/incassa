import 'package:uuid/uuid.dart';

import 'discount.dart';
import 'sell_type.dart';

class Item {
  String id = const Uuid().v4();
  double quantity;
  int price;
  String description;
  int departmentId;
  int? vat;
  Discount? discount;
  SellType selltype;
  int get subtotal => (price * quantity).round();
  int get total => subtotal - discounttotal;

  int get discounttotal {
    if (discount != null && discount?.percent != null) {
      return (subtotal * ((discount?.percent ?? 10000) / 10000)).round();
    } else if (discount != null && discount?.value != null) {
      return discount?.value ?? 0;
    }
    return 0;
  }

  int get nettotal {
    return (total / ((10000 + (vat ?? 0)) / 10000)).round();
  }

  int get vattotal {
    return total - nettotal;
  }

  Item(this.description, this.departmentId,
      {this.quantity = 1,
      this.price = 100,
      this.vat,
      this.discount,
      this.selltype = SellType.normal});
}




