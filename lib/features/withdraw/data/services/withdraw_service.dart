import 'package:chopper/chopper.dart';
import 'package:thrivve_assignment/core/utils/api_path.dart';

part 'withdraw_service.chopper.dart';

@ChopperApi(baseUrl: '')
abstract class WithdrawService extends ChopperService {
  static const listPaymentPath =
      'https://008915ae237e4a97a9f6f9344f43db74.api.mockbin.io';
  static const withdrawConfirmPath =
      'https://16b0271ef6904ad9bb4efc11937641fe.api.mockbin.io';

  static WithdrawService create() {
    final client = ChopperClient(
      baseUrl: Uri.parse(baseUrl),
      services: [
        _$WithdrawService(),
      ],
      interceptors: [
        CurlInterceptor(),
        HttpLoggingInterceptor(),
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
