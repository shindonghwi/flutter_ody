import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/data/models/ApiResponse.dart';
import 'package:ody_flutter_app/domain/repositories/remote/me/RemoteMeRepository.dart';

class PostMeLeaveUseCase {
  PostMeLeaveUseCase();

  final RemoteMeRepository _remoteMeRepository = GetIt.instance<RemoteMeRepository>();

  Future<ApiResponse<void>> call({required String reason}) async {
    return await _remoteMeRepository.postLeave(reason);
  }
}
