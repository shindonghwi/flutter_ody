import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/data/data_source/local/app/LocalAppDataSource.dart';

class GetAppPolicyUpdateUseCase {
  GetAppPolicyUpdateUseCase();

  final LocalAppDataSource _localDataSource = GetIt.instance<LocalAppDataSource>();

  Future<void> change(bool isAgreed) async =>
      await _localDataSource.setHasAgreedToPolicy(isAgreed);
}
