import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/data/models/ApiResponse.dart';
import 'package:odac_flutter_app/domain/repositories/local/app/LocalAppRepository.dart';

class GetAppPolicyCheckUseCase {
  GetAppPolicyCheckUseCase();

  final LocalAppRepository _localAppRepository = GetIt.instance<LocalAppRepository>();

  Future<ApiResponse<bool>> call() async {
    return await _localAppRepository.hasAgreedToPolicy();
  }
}
