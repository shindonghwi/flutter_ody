import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/data/models/ApiResponse.dart';
import 'package:ody_flutter_app/domain/models/me/GenderType.dart';
import 'package:ody_flutter_app/domain/repositories/remote/me/RemoteMeRepository.dart';

class PatchMeNicknameUseCase {
  PatchMeNicknameUseCase();

  final RemoteMeRepository _remoteMeRepository = GetIt.instance<RemoteMeRepository>();

  Future<ApiResponse<void>> call({required String nick}) async {
    return await _remoteMeRepository.patchNickname(nick);
  }
}
