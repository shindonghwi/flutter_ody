import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/data/models/ApiResponse.dart';
import 'package:odac_flutter_app/domain/models/me/GenderType.dart';
import 'package:odac_flutter_app/domain/repositories/remote/me/RemoteMeRepository.dart';

class PatchMeBirthdayUseCase {
  PatchMeBirthdayUseCase();

  final RemoteMeRepository _remoteMeRepository = GetIt.instance<RemoteMeRepository>();

  Future<ApiResponse<void>> call({required String birthday}) async {
    return await _remoteMeRepository.patchBirthday(birthday);
  }
}
