import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/data/data_source/local/app/LocalAppDataSource.dart';

class GetAppPolicyCheckUseCase {
  GetAppPolicyCheckUseCase();

  final LocalAppDataSource _localDataSource = GetIt.instance<LocalAppDataSource>();

  Future<bool> call() async {
    final agreedToPolicy = await _localDataSource.hasAgreedToPolicy();
    if (!agreedToPolicy) {
      return false;
    }
    return true;
  }
}
