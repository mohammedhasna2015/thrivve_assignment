import 'package:thrivve_assignment/core/base/parse_mock_data.dart';
import 'package:thrivve_assignment/features/withdraw/data/data_soruces/i_withdraw_datasource.dart';
import 'package:thrivve_assignment/features/withdraw/data/models/payment_model.dart';
import 'package:thrivve_assignment/features/withdraw/data/models/withdraw_confirm_model.dart';

class MockWithdrawDataSource extends IWithdrawDataSource {
  @override
  Future<WithdrawConfirmModel> confirmWithDraw() async {
    return parseJson(
      'assets/mockData/withdraw_confirm.json',
      WithdrawConfirmModel.fromJson,
    );
  }

  @override
  Future<List<PaymentModel>> listPayment() async {
    return parseJsonList(
      'assets/mockData/list_payment.json',
      PaymentModel.fromJson,
    );
  }
}
