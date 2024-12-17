import 'dart:async';
import 'dart:developer';

import 'package:chopper/chopper.dart';
import 'package:flutter/foundation.dart';

class HttpLoggingInterceptorCustom
    implements RequestInterceptor, ResponseInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) async {
    log('===================start curl ======================\n\n');

    // debugPrint('--> ${request.method} ${request.url}');
    if (!kReleaseMode) {
      final curlCommand = _buildCurlCommand(request);
      log(curlCommand);
      log('\n');
      log('===================end curl ======================\n\n');
    }

    log('\n');
    debugPrint('Headers: ${request.headers}');
    log('\n');
    debugPrint('Body: ${request.body}');

    return request;
  }

  @override
  FutureOr<Response> onResponse(Response response) async {
    debugPrint(
        '<-- ${response.statusCode} ${response.base.request?.method} ${response.base.request?.url}');
    if (!kReleaseMode) {
      log('response Body: ${response.body}');
      log('=========================================\n\n');
    }
    if (response.isSuccessful) {
      // Successful response (2xx status code)
      debugPrint('Request successful: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');
    } else {
      // Handle error response (non-2xx status code)
      debugPrint('Request failed with status code: ${response.statusCode}');
      debugPrint('Error response body: ${response.body}');
    }
    return response;
  }

  String _buildCurlCommand(Request request) {
    final curlOptions = [
      '-X ${request.method}',
      ...request.headers.entries.map((e) => '-H "${e.key}: ${e.value}"'),
    ];

    if (request.parameters.isNotEmpty) {
      final params = request.parameters.entries
          .map((e) => '${e.key}=${Uri.encodeComponent(e.value.toString())}')
          .join('&');
      curlOptions.add('-G');
      curlOptions.add('--data-urlencode "$params"');
    }

    if (request.body != null) {
      curlOptions.add('-H "Content-Type: application/json"');
      curlOptions.add('-d \'${request.body}\'');
    }

    curlOptions.add(request.url.toString());

    return 'curl ${curlOptions.join(' ')}';
  }
}
