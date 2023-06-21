import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/data/data_source/remote/auth/RemoteAuthApi.dart';
import 'package:ody_flutter_app/data/models/ApiResponse.dart';
import 'package:ody_flutter_app/data/models/auth/RequestSocialLoginModel.dart';
import 'package:ody_flutter_app/data/models/auth/ResponseSocialLoginModel.dart';
import 'package:ody_flutter_app/domain/models/auth/SocialLoginModel.dart';
import 'package:ody_flutter_app/domain/repositories/remote/auth/RemoteAuthRepository.dart';

class RemoteAuthRepositoryImpl implements RemoteAuthRepository {
  RemoteAuthRepositoryImpl();

  @override
  Future<ApiResponse<SocialLoginModel>> doGoogleLogin() {
    RemoteAuthApi remoteAuthApi = GetIt.instance<RemoteAuthApi>();
    return remoteAuthApi.doGoogleLogin();
  }

  @override
  Future<ApiResponse<ResponseSocialLoginModel>> postSocialLogin({
    required RequestSocialLoginModel requestSocialLoginModel,
  }) {
    RemoteAuthApi remoteAuthApi = GetIt.instance<RemoteAuthApi>();
    return remoteAuthApi.postSocialLogin(
      requestSocialLoginModel: requestSocialLoginModel,
    );
  }
}
