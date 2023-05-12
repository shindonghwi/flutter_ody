import 'package:odac_flutter_app/data/data_source/local/app/LocalAppDataSource.dart';
import 'package:odac_flutter_app/data/data_source/local/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalAppDataSourceImpl implements LocalAppDataSource {

  final String appUsePolicyKey = SharedKeyHelper.fromString(SharedKey.APP_USE_POLICY);

  @override
  Future<bool> hasAgreedToPolicy() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(appUsePolicyKey) ?? false;
  }

  @override
  Future<void> setHasAgreedToPolicy(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(appUsePolicyKey, value);
  }
}