import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/data/models/ApiResponse.dart';
import 'package:ody_flutter_app/data/models/auth/RequestSocialLoginModel.dart';
import 'package:ody_flutter_app/data/models/auth/ResponseSocialLoginModel.dart';
import 'package:ody_flutter_app/domain/models/auth/LoginPlatform.dart';
import 'package:ody_flutter_app/domain/repositories/remote/auth/RemoteAuthRepository.dart';
import 'package:ody_flutter_app/firebase/FirebaseCloudMessage.dart';

class PostSocialLoginInUseCase {
  PostSocialLoginInUseCase();

  final RemoteAuthRepository _remoteAuthRepository = GetIt.instance<RemoteAuthRepository>();

  Future<ApiResponse<ResponseSocialLoginModel>> call({
    required LoginPlatform platform,
    required String accessToken,
    String deviceToken = "",
  }) async {
    final token = deviceToken.toString().isNotEmpty ? deviceToken : await FirebaseCloudMessage.getToken() ?? "";

    final res = await _remoteAuthRepository.postSocialLogin(
      requestSocialLoginModel: RequestSocialLoginModel(
        type: LoginPlatformHelper.fromString(platform),
        accessToken: accessToken,
        deviceToken: token,
      ),
    );

    return res;
  }
}
