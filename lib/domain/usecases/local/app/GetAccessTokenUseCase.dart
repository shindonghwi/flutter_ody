import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/data/models/ApiResponse.dart';
import 'package:odac_flutter_app/domain/models/auth/SocialLoginModel.dart';
import 'package:odac_flutter_app/domain/repositories/local/app/LocalAppRepository.dart';
import 'package:odac_flutter_app/presentation/utils/dto/Pair.dart';

class GetAccessTokenUseCase {
  GetAccessTokenUseCase();

  final LocalAppRepository _localAppRepository = GetIt.instance<LocalAppRepository>();

  Future<SocialLoginModel?> call() async {
    return await _localAppRepository.getAccessToken();
  }
}
