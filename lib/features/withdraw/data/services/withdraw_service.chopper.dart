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
    final Uri $url = Uri.parse('V3/40f5959f-e678-47b9-ae54-da3aac1c5f40');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> confirmWithDraw() {
    final Uri $url = Uri.parse('V3/705813b5-2b16-4a07-bb23-0d19425d5efe');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
