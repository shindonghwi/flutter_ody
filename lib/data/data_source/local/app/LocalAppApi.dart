import 'package:odac_flutter_app/data/data_source/local/constant.dart';
import 'package:odac_flutter_app/data/models/LocalMessage.dart';
import 'package:odac_flutter_app/data/models/ApiResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalAppApi {
  LocalAppApi();

  final String appUsePolicyKey = SharedKeyHelper.fromString(SharedKey.APP_USE_POLICY);

  Future<ApiResponse<bool>> hasAgreedToPolicy() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return ApiResponse(
        status: 200,
        message: LocalMessage.localSaveFailMessage,
        data: prefs.getBool(appUsePolicyKey) ?? false,
      );
    } catch (e) {
      return ApiResponse(
        status: 200,
        message: e.toString(),
        data: false,
      );
    }
  }

  Future<ApiResponse<bool>> setHasAgreedToPolicy(bool value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(appUsePolicyKey, value);
      return ApiResponse(
        status: 200,
        message: "",
        data: true,
      );
    } catch (e) {
      return ApiResponse(
        status: 200,
        message: LocalMessage.localSaveFailMessage,
        data: false,
      );
    }
  }
}
