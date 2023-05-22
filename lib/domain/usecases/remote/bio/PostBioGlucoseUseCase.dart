import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/data/models/ApiResponse.dart';
import 'package:odac_flutter_app/data/models/bio/RequestBioGlucoseModel.dart';
import 'package:odac_flutter_app/domain/models/bio/GlucoseMesaureType.dart';
import 'package:odac_flutter_app/domain/repositories/remote/bio/RemoteBioRepository.dart';

class PostBioGlucoseUseCase {
  PostBioGlucoseUseCase();

  final RemoteBioRepository _remoteBioRepository = GetIt.instance<RemoteBioRepository>();

  Future<ApiResponse<void>> call({
    required String time,
    required GlucoseMeasureType type,
    required int glucose,
    required String? memo,
    required String? remindTime,
  }) async {
    final res = await _remoteBioRepository.postGlucose(
      RequestBioGlucoseModel(
        time: time,
        type: type,
        glucose: glucose,
        memo: memo,
        remindTime: remindTime,
      ),
    );
    return res;
  }
}
