import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/data/data_source/local/SharedKey.dart';
import 'package:odac_flutter_app/data/models/ApiResponse.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalAppApi {
  LocalAppApi();

  final String appUsePolicyKey = SharedKeyHelper.fromString(SharedKey.APP_USE_POLICY);

  AppLocalization get _getAppLocalization => GetIt.instance<AppLocalization>();

  Future<ApiResponse<bool>> hasAgreedToPolicy() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return ApiResponse(
        status: 200,
        message: _getAppLocalization.get().message_save_success,
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
        message: _getAppLocalization.get().message_save_success,
        data: true,
      );
    } catch (e) {
      return ApiResponse(
        status: 200,
        message: e.toString(),
        data: false,
      );
    }
  }
}
