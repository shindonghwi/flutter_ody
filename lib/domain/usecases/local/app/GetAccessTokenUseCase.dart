import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/data/models/ApiResponse.dart';
import 'package:odac_flutter_app/domain/repositories/local/app/LocalAppRepository.dart';

class GetAccessTokenUseCase {
  GetAccessTokenUseCase();

  final LocalAppRepository _localAppRepository = GetIt.instance<LocalAppRepository>();

  Future<ApiResponse<String>> call() async {
    return await _localAppRepository.getAccessToken();
  }
}
