import 'package:RCHGatewayClient/api.dart';
import '../common/errors/advanced_error.dart';
import '../common/errors/erroror.dart';
import 'base_service.dart';

class PrintService extends BaseService {
  Future<ErrorOr<PrintBillResponseDTO>> print(bool dumpDgfe, BillToPrintDTO bill,
      {String? deviceId}) async {
    try {
      var value = await PrinterApi()
          .apiPrinterFiscalPrintDgfePost(dumpDgfe, billToPrintDTO: bill, id: deviceId);
      if (value != null) {
        return ErrorOr(value);
      } else {
        return ErrorOr(AdvancedError.failure) as ErrorOr<PrintBillResponseDTO>;
      }
    } on ApiException catch (_, e) {
      return manageApiErrorResult(_.code) as ErrorOr<PrintBillResponseDTO>;
    }
  }
}
