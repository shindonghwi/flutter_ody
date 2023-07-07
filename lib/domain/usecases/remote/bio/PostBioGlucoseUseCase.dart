import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/data/models/ApiResponse.dart';
import 'package:ody_flutter_app/data/models/bio/RequestBioGlucoseModel.dart';
import 'package:ody_flutter_app/domain/models/bio/GlucoseMesaureType.dart';
import 'package:ody_flutter_app/domain/repositories/remote/bio/RemoteBioRepository.dart';
import 'package:ody_flutter_app/presentation/utils/date/DateParser.dart';

class PostBioGlucoseUseCase {
  PostBioGlucoseUseCase();

  final RemoteBioRepository _remoteBioRepository = GetIt.instance<RemoteBioRepository>();

  Future<ApiResponse<void>> call({
    required DateTime time,
    required GlucoseMeasureType type,
    required int glucose,
    required String? memo,
    required int? remindTime,
  }) async {
    final res = await _remoteBioRepository.postGlucose(
      RequestBioGlucoseModel(
        time: DateParser.getGlobalTimeDate(time),
        type: type.name,
        glucose: glucose,
        memo: memo,
        remindTime: remindTime,
      ),
    );
    return res;
  }
}
