import 'package:RCHGatewayClient/api.dart';
import 'package:incassa/domain/item.dart';
import 'package:incassa/domain/sell_type.dart' as domain;
import 'package:incassa/domain/bill.dart' as domain;
import 'package:incassa/domain/payment.dart' as domain;
import 'package:incassa/domain/order.dart' as domain;

import '../../domain/discount.dart';

extension BillExtension on domain.Bill {
  BillToPrintDTO toGatewayBill() {
    return BillToPrintDTO(
        billType: BillType.number0,
        orders: orders.map((e) => e.toGatewayOrder()).toList(),
        paymentItems:
            paymentItems.map((e) => e.toGatewayPaymentItem()).toList(),
        discount: discount?.toGatewayDiscountItem());
  }
}

extension OrderExtension on domain.Order {
  OrderToPrintDTO toGatewayOrder() {
    return OrderToPrintDTO(
      index: index,
      lineItems: lineItems.map((e) => e.toGatewayLineItem()).toList()
      );
  }
}

extension ItemExtension on Item {
  LineItemToPrintDTO toGatewayLineItem() {
    return LineItemToPrintDTO(
        quantity: quantity,
        price: price,
        description: description,
        departmentId: departmentId,
        vat: vat,
        discount: discount?.toGatewayDiscountItem(),
        sellType: selltype.toGatewaySellType());
  }
}

extension PaymentExtension on domain.Payment {
  PaymentItemToPrintDTO toGatewayPaymentItem() {
    return PaymentItemToPrintDTO(paymentId: paymentId, value: value);
  }
}

extension DiscountExtension on Discount {
  DiscountItemToPrintDTO toGatewayDiscountItem() {
    return DiscountItemToPrintDTO();
  }
}

extension SellTypeExtension on domain.SellType {
  SellType toGatewaySellType() {
    switch (this) {
      case domain.SellType.free:
        return SellType.number1;
      case domain.SellType.advance_payment:
        return SellType.number2;
      case domain.SellType.coupon_single_use:
        return SellType.number3;
      case domain.SellType.normal:
      default:
        return SellType.number0;
    }
  }
}
