import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:odac_flutter_app/app/env/Environment.dart';

class Service {
  static String baseUrl = "${Environment.apiUrl}/${Environment.apiVersion}";

  static Map<String, String> headers = {
    'Accept-Language': 'ko-KR',
    'Application-Client-ID': 'ody-android',
    'Application-Time-Zone': 'ody-android',
    'Accept': '*/*',
    'Connection': 'keep-alive',
  };

  static setHeader({
    required String languageCode,
    required String countryCode,
    required String timeZone,
    String token = "",
    String clientId = "ody-android",
  }) {
    headers = {
      'Content-Type': 'application/json',
      'Accept-Language': '$languageCode-$countryCode',
      'Application-Client-ID': clientId,
      'Application-Time-Zone': timeZone,
      'Authorization': 'Bearer $token',
    };
    debugPrint('setHeader: $headers');
  }

  static addHeader({
    required String key,
    required String value,
  }) {
    headers[key] = value;
    debugPrint('addHeader: $headers');
  }

  static Future<Response> getApi({
    required ServiceType type,
    required String? endPoint,
  }) async {
    final url = Uri.parse(
        '$baseUrl/${_ServiceTypeHelper.fromString(type)}${endPoint == null ? "" : "/$endPoint"}');
    debugPrint('\nrequest Url: $url');
    debugPrint('request header: $headers\n');

    final res = await http.get(
      url,
      headers: headers,
    );
    debugPrint('\http response statusCode: ${res.statusCode}');
    debugPrint('\http response method: ${res.request?.method.toString()}');
    debugPrint('\http response body: ${res.body}');
    return res;
  }

  static Future<Response> postApi({
    required ServiceType type,
    required String? endPoint,
    required Map<String, dynamic> jsonBody,
  }) async {
    final url = Uri.parse(
        '$baseUrl/${_ServiceTypeHelper.fromString(type)}${endPoint == null ? "" : "/$endPoint"}');
    debugPrint('\nrequest Url: $url');
    debugPrint('request header: $headers');
    debugPrint('request body: $jsonBody\n', wrapWidth: 2048);

    final res = await http.post(
      url,
      headers: headers,
      body: jsonEncode(jsonBody),
    );
    debugPrint('\http response statusCode: ${res.statusCode}');
    debugPrint('\http response method: ${res.request?.method.toString()}');
    debugPrint('\http response body: ${res.body}');
    return res;
  }

  static Future<Response> patchApi({
    required ServiceType type,
    required String? endPoint,
    required Map<String, dynamic> jsonBody,
  }) async {
    final url = Uri.parse(
        '$baseUrl/${_ServiceTypeHelper.fromString(type)}${endPoint == null ? "" : "/$endPoint"}');
    debugPrint('\nrequest Url: $url');
    debugPrint('request header: $headers');
    debugPrint('request body: $jsonBody\n', wrapWidth: 2048);

    final res = await http.patch(
      url,
      headers: headers,
      body: jsonEncode(jsonBody),
    );
    debugPrint('\http response statusCode: ${res.statusCode}');
    debugPrint('\http response method: ${res.request?.method.toString()}');
    debugPrint('\http response body: ${res.body}');
    return res;
  }

  static Future<Response> deleteApi({
    required ServiceType type,
    required String? endPoint,
    required Map<String, dynamic>? jsonBody,
  }) async {
    final url = Uri.parse(
        '$baseUrl/${_ServiceTypeHelper.fromString(type)}${endPoint == null ? "" : "/$endPoint"}');
    debugPrint('\nrequest Url: $url');
    debugPrint('request header: $headers');
    debugPrint('request body: $jsonBody\n', wrapWidth: 2048);

    final res = await http.delete(
      url,
      headers: headers,
      body: jsonEncode(jsonBody),
    );
    debugPrint('\http response statusCode: ${res.statusCode}');
    debugPrint('\http response method: ${res.request?.method.toString()}');
    debugPrint('\http response body: ${res.body}');
    return res;
  }

}

enum ServiceType {
  Auth,
  Me,
  Bio,
  Validation,
}

class _ServiceTypeHelper {
  static const Map<ServiceType, String> _stringToEnum = {
    ServiceType.Auth: "auth",
    ServiceType.Me: "me",
    ServiceType.Bio: "bio",
    ServiceType.Validation: "validation"
  };

  static String fromString(ServiceType type) => _stringToEnum[type] ?? "";
}
