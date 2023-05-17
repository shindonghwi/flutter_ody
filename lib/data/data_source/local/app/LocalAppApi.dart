import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:odac_flutter_app/data/data_source/local/SharedKey.dart';
import 'package:odac_flutter_app/domain/models/auth/LoginPlatform.dart';
import 'package:odac_flutter_app/domain/models/auth/SocialLoginModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalAppApi {
  LocalAppApi();

  final String appUsePolicyKey = SharedKeyHelper.fromString(SharedKey.APP_USE_POLICY);
  final String socialAccessToken = SharedKeyHelper.fromString(SharedKey.SOCIAL_ACCESS_TOKEN);

  Future<bool> hasAgreedToPolicy() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(appUsePolicyKey) ?? false;
  }

  Future<void> setHasAgreedToPolicy(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(appUsePolicyKey, value);
  }

  Future<void> saveSocialAccessToken(LoginPlatform platform, String? token) async {
    final prefs = await SharedPreferences.getInstance();
    final SocialLoginModel model = SocialLoginModel(platform, token ?? "");
    await prefs.setString(socialAccessToken, jsonEncode(model.toJson()));
  }

  Future<SocialLoginModel?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String socialJsonData = prefs.getString(socialAccessToken) ?? "";

    if (socialJsonData.isNotEmpty){
      final model = SocialLoginModel.fromJson(jsonDecode(socialJsonData));
      return SocialLoginModel(model.loginPlatform, model.accessToken);
    }else{
      return null;
    }
  }
}
