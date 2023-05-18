import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/data/data_source/remote/auth/RemoteAuthApi.dart';
import 'package:odac_flutter_app/data/data_source/remote/me/RemoteMeApi.dart';
import 'package:odac_flutter_app/data/models/ApiResponse.dart';
import 'package:odac_flutter_app/data/models/auth/RequestSocialLoginModel.dart';
import 'package:odac_flutter_app/data/models/auth/ResponseSocialLoginModel.dart';
import 'package:odac_flutter_app/data/models/me/ResponseMeInfoModel.dart';
import 'package:odac_flutter_app/domain/models/auth/SocialLoginModel.dart';
import 'package:odac_flutter_app/domain/repositories/remote/auth/RemoteAuthRepository.dart';
import 'package:odac_flutter_app/domain/repositories/remote/me/RemoteMeRepository.dart';

class RemoteMeRepositoryImpl implements RemoteMeRepository {
  RemoteMeRepositoryImpl();

  @override
  Future<ApiResponse<ResponseMeInfoModel>> getMe() {
    RemoteMeApi remoteMeApi = GetIt.instance<RemoteMeApi>();
    return remoteMeApi.getMe();
  }
}
