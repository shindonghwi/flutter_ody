import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/data/models/ApiListResponse.dart';
import 'package:ody_flutter_app/data/models/ApiResponse.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioForDaysModel.dart';
import 'package:ody_flutter_app/domain/repositories/remote/bio/RemoteBioRepository.dart';

class GetBioHistoryForDaysUseCase {
  GetBioHistoryForDaysUseCase();

  final RemoteBioRepository _remoteBioRepository = GetIt.instance<RemoteBioRepository>();

  Future<ApiResponse<ResponseBioForDaysModel>> call({
    required int year,
    required int month,
    required int day,
  }) async {
    final res = await _remoteBioRepository.getBioHistoryForDays(year, month, day);
    return res;
  }
}
