import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/data/data_source/local/app/LocalAppApi.dart';
import 'package:odac_flutter_app/data/data_source/remote/auth/RemoteAuthApi.dart';
import 'package:odac_flutter_app/data/models/ApiResponse.dart';
import 'package:odac_flutter_app/domain/repositories/local/app/LocalAppRepository.dart';
import 'package:odac_flutter_app/domain/repositories/remote/auth/RemoteAuthRepository.dart';

class RemoteAuthRepositoryImpl implements RemoteAuthRepository {
  RemoteAuthRepositoryImpl();

  @override
  Future<ApiResponse<bool>> doGoogleLogin() {
    RemoteAuthApi remoteAuthApi = GetIt.instance<RemoteAuthApi>();
    return remoteAuthApi.doGoogleLogin();
  }

}
