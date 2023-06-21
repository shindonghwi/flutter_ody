import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/domain/repositories/local/app/LocalAppRepository.dart';

class GetAppPolicyCheckUseCase {
  GetAppPolicyCheckUseCase();

  final LocalAppRepository _localAppRepository = GetIt.instance<LocalAppRepository>();

  Future<bool> call() async {
    return await _localAppRepository.hasAgreedToPolicy();
  }
}
