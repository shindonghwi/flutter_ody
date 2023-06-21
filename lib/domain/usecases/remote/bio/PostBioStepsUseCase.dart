import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/data/models/ApiResponse.dart';
import 'package:ody_flutter_app/data/models/bio/RequestBioStepsModel.dart';
import 'package:ody_flutter_app/domain/repositories/remote/bio/RemoteBioRepository.dart';

class PostBioStepsUseCase {
  PostBioStepsUseCase();

  final RemoteBioRepository _remoteBioRepository = GetIt.instance<RemoteBioRepository>();

  Future<ApiResponse<void>> call({
    required String time,
    required int count,
  }) async {
    final res = await _remoteBioRepository.postSteps(
      RequestBioStepsModel(
        time: time,
        count: count,
      ),
    );
    return res;
  }
}
