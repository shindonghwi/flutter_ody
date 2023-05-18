import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/data/models/ApiResponse.dart';
import 'package:odac_flutter_app/data/models/auth/RequestSocialLoginModel.dart';
import 'package:odac_flutter_app/data/models/auth/ResponseSocialLoginModel.dart';
import 'package:odac_flutter_app/data/models/me/ResponseMeInfoModel.dart';
import 'package:odac_flutter_app/domain/models/auth/LoginPlatform.dart';
import 'package:odac_flutter_app/domain/repositories/remote/auth/RemoteAuthRepository.dart';
import 'package:odac_flutter_app/domain/repositories/remote/me/RemoteMeRepository.dart';

class GetMeInfoUseCase {
  GetMeInfoUseCase();

  final RemoteMeRepository _remoteMeRepository =
      GetIt.instance<RemoteMeRepository>();

  Future<ApiResponse<ResponseMeInfoModel>> call() async {
    return await _remoteMeRepository.getMe();
  }
}
