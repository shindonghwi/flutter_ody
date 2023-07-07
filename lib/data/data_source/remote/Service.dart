import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:ody_flutter_app/app/env/Environment.dart';
import 'package:ody_flutter_app/data/data_source/remote/BaseApiUtil.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class Service {
  static AppLocalization get _getAppLocalization => GetIt.instance<AppLocalization>();
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

  static Future<bool> isNetworkAvailable() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.none ? false : true;
  }

  static Future<Response> getApi({
    required ServiceType type,
    required String? endPoint,
  }) async {
    if (await isNetworkAvailable()) {
      final url = Uri.parse('$baseUrl/${_ServiceTypeHelper.fromString(type)}${endPoint == null ? "" : "/$endPoint"}');
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
    } else {
      return BaseApiUtil.createResponse(_getAppLocalization.get().message_network_required.toString(), 406);
    }
  }


  static Future<Response> postApi({
    required ServiceType type,
    required String? endPoint,
    required Map<String, dynamic> jsonBody,
  }) async {
    if (await isNetworkAvailable()) {
      final url = Uri.parse('$baseUrl/${_ServiceTypeHelper.fromString(type)}${endPoint == null ? "" : "/$endPoint"}');
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
    } else {
      return BaseApiUtil.createResponse(_getAppLocalization.get().message_network_required.toString(), 406);
    }
  }

  static Future<Response> patchApi({
    required ServiceType type,
    required String? endPoint,
    required Map<String, dynamic> jsonBody,
  }) async {
    if (await isNetworkAvailable()) {
      final url = Uri.parse('$baseUrl/${_ServiceTypeHelper.fromString(type)}${endPoint == null ? "" : "/$endPoint"}');
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
    } else {
      return BaseApiUtil.createResponse(_getAppLocalization.get().message_network_required.toString(), 406);
    }
  }

  static Future<Response> deleteApi({
    required ServiceType type,
    required String? endPoint,
    required Map<String, dynamic>? jsonBody,
  }) async {
    if (await isNetworkAvailable()) {
      final url = Uri.parse('$baseUrl/${_ServiceTypeHelper.fromString(type)}${endPoint == null ? "" : "/$endPoint"}');
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
    } else {
      return BaseApiUtil.createResponse(_getAppLocalization.get().message_network_required.toString(), 406);
    }
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
