import 'dart:convert';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:thrivve_assignment/core/base/exceptions.dart';
// Import the class to be tested and its dependencies
import 'package:thrivve_assignment/features/withdraw/data/data_soruces/i_withdraw_datasource.dart';
import 'package:thrivve_assignment/features/withdraw/data/data_soruces/withdraw_datasource.dart';
import 'package:thrivve_assignment/features/withdraw/data/models/withdraw_confirm_model.dart';
import 'package:thrivve_assignment/features/withdraw/data/services/withdraw_service.dart';

import 'withdraw_datasource_test.mocks.dart';

@GenerateMocks([
  WithdrawService,
])
void main() {
  late IWithdrawDataSource dataSource;
  late MockWithdrawService mockWithdrawService;
  setUpAll(() {
    provideDummy<Response<dynamic>>(
      Response(
        http.Response('{}', 200),
        {},
      ),
    );
  });
  setUp(() {
    mockWithdrawService = MockWithdrawService();
    dataSource = WithdrawDataSource(mockWithdrawService);
  });

  group('confirmWithdraw', () {
    final resultModel = WithdrawConfirmModel(
        title: "Confirmed successfully",
        message: "Your payment request has been placed successfully.");

    test('confirmWithDraw returns WithdrawConfirmModel successfully', () async {
      final mockHttpResponse = http.Response(
        jsonEncode(resultModel.toJson()),
        200,
      );

      final mockResponse = Response(mockHttpResponse, resultModel.toJson());

      when(mockWithdrawService.confirmWithDraw())
          .thenAnswer((_) async => mockResponse);

      final result = await dataSource.confirmWithDraw();

      expect(result, isA<WithdrawConfirmModel>());
      expect(result.title, 'Confirmed successfully');
      expect(
          result.message, 'Your payment request has been placed successfully.');

      verify(mockWithdrawService.confirmWithDraw()).called(1);
    });

    test('confirmWithDraw handles validation error', () async {
      when(mockWithdrawService.confirmWithDraw())
          .thenAnswer((_) async => Response(
                http.Response('{invalid-json}', 200),
                null,
              ));

      expect(
        () => dataSource.confirmWithDraw(),
        throwsA(isA<ValidationException>()),
      );
    });

    test('confirmWithDraw handles network error', () async {
      when(mockWithdrawService.confirmWithDraw())
          .thenThrow(SocketException('No internet connection'));

      expect(
        () => dataSource.confirmWithDraw(),
        throwsA(isA<NetworkException>()),
      );
    });

    test('confirmWithDraw handles server error', () async {
      when(mockWithdrawService.confirmWithDraw())
          .thenAnswer((_) async => Response(
                http.Response('{"error": "Server Error"}', 500),
                null,
              ));

      expect(
        () => dataSource.confirmWithDraw(),
        throwsA(isA<ServerException>()),
      );
    });
  });
}

String jsonEncode(dynamic object) {
  return json.encode(object);
}
