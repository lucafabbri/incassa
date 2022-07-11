import 'order.dart';
import 'payment.dart';
import 'discount.dart';

class Bill {
  List<Order> orders = [Order()];
  List<Payment> paymentItems = [];
  Discount? discount;
}
