import 'package:chopper/chopper.dart';
import 'package:thrivve_assignment/core/utils/api_path.dart';
import 'package:thrivve_assignment/core/utils/logger_service.dart';

part 'withdraw_service.chopper.dart';

@ChopperApi(baseUrl: 'V3')
abstract class WithdrawService extends ChopperService {
  static const listPaymentPath = '40f5959f-e678-47b9-ae54-da3aac1c5f40';
  static const withdrawConfirmPath = '705813b5-2b16-4a07-bb23-0d19425d5efe';

  static WithdrawService create() {
    final client = ChopperClient(
      baseUrl: Uri.parse(baseUrl),
      services: [
        _$WithdrawService(),
      ],
      interceptors: [
        HttpLoggingInterceptorCustom(),
      ],
      converter: JsonConverter(),
    );
    return _$WithdrawService(client);
  }

  @Get(path: listPaymentPath)
  Future<Response> listPayment();
  @Get(path: withdrawConfirmPath)
  Future<Response> confirmWithDraw();
}
