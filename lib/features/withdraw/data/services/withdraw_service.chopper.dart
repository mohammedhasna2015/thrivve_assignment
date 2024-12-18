// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdraw_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$WithdrawService extends WithdrawService {
  _$WithdrawService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = WithdrawService;

  @override
  Future<Response<dynamic>> listPayment() {
    final Uri $url =
        Uri.parse('https://008915ae237e4a97a9f6f9344f43db74.api.mockbin.io');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> confirmWithDraw() {
    final Uri $url =
        Uri.parse('https://16b0271ef6904ad9bb4efc11937641fe.api.mockbin.io');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
