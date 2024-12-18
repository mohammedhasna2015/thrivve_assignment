import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:thrivve_assignment/core/base/exceptions.dart';

abstract class BaseDataSource {
  Future<T> executeRequest<T>({
    required Future<Response> Function() request,
    required T Function(dynamic json) parser,
  }) async {
    try {
      final response = await request();

      if (!response.isSuccessful) {
        throw ServerException(
          'HTTP Error: ${response.statusCode}',
          response.statusCode,
        );
      }

      final body = response.body;
      if (body == null) {
        throw ValidationException('Empty response body', {});
      }

      try {
        return parser(body);
      } on FormatException catch (e) {
        throw ValidationException('Invalid response format', {
          'body': [e.message]
        });
      }
    } on SocketException catch (e) {
      throw NetworkException(e.message);
    } on FormatException catch (e) {
      throw ValidationException(e.message, {});
    } catch (e) {
      if (e is ServerException ||
          e is NetworkException ||
          e is ValidationException) {
        rethrow;
      }
      throw ServerException(e.toString(), 500);
    }
  }
}
