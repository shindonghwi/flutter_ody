import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/data/models/ApiResponse.dart';
import 'package:ody_flutter_app/data/models/me/ResponseMeInfoModel.dart';
import 'package:ody_flutter_app/domain/repositories/remote/me/RemoteMeRepository.dart';
import 'package:ody_flutter_app/presentation/features/cache/UserCache.dart';

class GetMeInfoUseCase {
  GetMeInfoUseCase();

  final RemoteMeRepository _remoteMeRepository = GetIt.instance<RemoteMeRepository>();

  Future<ApiResponse<ResponseMeInfoModel>> call() async {
    final meInfo = await _remoteMeRepository.getMe();
    userCache.setUserInfo(meInfo.data);
    return meInfo;
  }
}
