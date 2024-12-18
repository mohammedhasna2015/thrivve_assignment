import 'dart:convert';

import 'package:flutter/services.dart';

Future<T> parseJson<T>(
    String path, T Function(Map<String, dynamic>) fromJson) async {
  try {
    final result = await rootBundle.loadString(path);
    final jsonMap = json.decode(result) as Map<String, dynamic>;
    return fromJson(jsonMap);
  } catch (e) {
    throw Exception('Failed to parse JSON from $path: $e');
  }
}

Future<List<T>> parseJsonList<T>(
    String path, T Function(Map<String, dynamic>) fromJson) async {
  final result = await rootBundle.loadString(path);
  final List<dynamic> jsonList = json.decode(result);
  return jsonList
      .map((json) => fromJson(json as Map<String, dynamic>))
      .toList();
}
